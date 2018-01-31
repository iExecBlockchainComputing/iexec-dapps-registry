pragma solidity ^0.4.11;

import "./OwnerChain.sol";
import "./StorageContracts.sol";

/// Per-bicycle contract containing methods for transferring ownership, 
// buying & selling and uploading files associated ẃith the bike.
contract Bicycle {

    ///////////////////////////
    ///// public members //////
    ///////////////////////////

    // Essential bike information
    bytes32 public serialNumber;
    string public manufacturer;
    address public owner;

    // States of the buy/sell cycle, inactive is the default state.
    enum State { Inactive, Acknowledged, Locked }
    State public purchaseState;
    
    // Address which has been authorized by selling to proceed with purchase
    address public acknowledgedBuyer;
    
    // Requested price for bike
    uint public requestedValue;

    ///////////////////////////
    ///// private members /////
    ///////////////////////////

    // List of all previous and current bike owners
    address[] private ownerlist;
    
    // Swarm Data Structures, adapted from: 
    // https://bitbucket.org/rhitchens2/soliditycrud/src/83703dcaf4d0c4b0d6adc0377455c4f257aa29a7/contracts/SolidityCRUD-part2.sol
    struct FileStruct {
      bytes32 hash;
      uint timestamp;
      uint index;
    }
    mapping(bytes32 => FileStruct) private fileStructs;
    bytes32[] private fileIndex;

    // Reference to storage is needed to retrieve current version of ownerchain
    AbstractStorageContract private storageContract;

    ///////////////////////////
    //////// modifiers ////////
    ///////////////////////////

    modifier condition(bool _condition) {
        if (!_condition) throw;
        _;
    }

    modifier onlyBuyer() {
        if (msg.sender != acknowledgedBuyer) throw;
        _;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) throw;
        _;
    }

    modifier inState(State _state) {
        if (purchaseState != _state) throw;
        _;
    }

    ////////////////////////
    //////// events ////////
    ////////////////////////

    event aborted();
    event rejected();
    event purchaseConfirmed(address newOwner);
    event itemReceived();
    event ownershipTransferred;
    event fileAdded(bytes32 hash, uint timestamp, uint index);

    /////////////////////////
    //////// methods ////////
    /////////////////////////

    // Create a new bicycle contract
    function Bicycle(bytes32 _serialNumber, string _manufacturerName, address _owner, address _storageContract) {
        serialNumber = _serialNumber;
        manufacturer = _manufacturerName;
        owner = _owner;
        ownerlist.push(owner);
        purchaseState = State.Inactive;
        storageContract = AbstractStorageContract(_storageContract);
    }

    /// Returns if hash is in file list
    function hasFile(bytes32 _hash)
        public
        constant
        returns(bool _hasIndeed)
    {
        if (fileIndex.length == 0) return false;
        return (fileIndex[fileStructs[_hash].index] == _hash);
    }
    
    /// Adds hash of file to list of files, used for swarm file uploads.
    function addFile(bytes32 _hash)
        onlyOwner
    {
        if (hasFile(_hash)) return;
        fileStructs[_hash].timestamp = block.timestamp;
        fileStructs[_hash].index     = fileIndex.push(_hash) - 1;
        fileStructs[_hash].hash      = _hash;
        fileAdded(_hash, block.timestamp, fileStructs[_hash].index);
    }
    
    /// Returns number of stored files
    function getFileCount()
        public
        constant
        returns (uint _count)
    {
        return fileIndex.length;
    }
    
    /// Returns hash of file or 0 not present
    function getFile(uint _i)
        public
        constant
        returns (bytes32 _hash)
    {
        return fileIndex[_i];
    }

    /// Abort the purchase and reclaim the ether.
    /// Can only be called by the seller before
    /// the contract is locked.
    function abortPurchase()
        onlyOwner
        inState(State.Acknowledged)
    {
        aborted();
        purchaseState = State.Inactive;
        acknowledgedBuyer = address(0);
        requestedValue = 0;
    }


    /// Reject and offer from the seller
    /// Can only be called by the buyer before confirming 
    /// the purchase
    function rejectOffer()
        onlyBuyer
        inState(State.Acknowledged)
    {
        rejected();
        purchaseState = State.Inactive;
        acknowledgedBuyer = address(0);
        requestedValue = 0;
    }

    /// Confirm the purchase as buyer.
    /// Transaction has to include `requestedValue` ether.
    /// The ether will be locked until confirmReceived
    /// is called.
    function confirmPurchase()
    	onlyBuyer
        inState(State.Acknowledged)
        condition(msg.value == requestedValue)
        payable
    {
        purchaseConfirmed(msg.sender);
        purchaseState = State.Locked;
    }

    // Confirm the purchase and directly pay out the ether
    // without needing to confirm receipt
    function confirmPurchaseNoEscrow()
        onlyBuyer
        inState(State.Acknowledged)
        condition(msg.value == requestedValue)
        payable
    {
        purchaseConfirmed(msg.sender);
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        purchaseState = State.Inactive;

        if (ownerlist.length <= 1) {
            if (!owner.send(this.balance)) throw;            
        } else {
            // send incentive of 5% to previous owner
            if (!owner.send(this.balance * 19 / 20)) throw;
            if (!ownerlist[ownerlist.length - 2].send(uint(this.balance))) throw;
        }

        // Retrieve the current ownerchain address from the storage contract
        OwnerChain ownerchain = OwnerChain(storageContract.ownerchainAddress());
        // Let ownerchain update its data structures
        ownerchain.bikeOwnershipTransferred(owner, acknowledgedBuyer, serialNumber);

        owner = acknowledgedBuyer;
        ownerlist.push(owner);
        acknowledgedBuyer = address(0);
    }

    /// Allow a particular address to purchase the bike for the requested value.
    function allowPurchase(address allowedBuyer, uint _requestedValue) 
        onlyOwner
        inState(State.Inactive)
    {
        acknowledgedBuyer = allowedBuyer;
        requestedValue = _requestedValue;
        purchaseState = State.Acknowledged;
    }

    /// Confirm that the buyer received the item.
    /// This will release the locked ether.
    function confirmReceived()
        onlyBuyer
        inState(State.Locked)
    {
        itemReceived();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        purchaseState = State.Inactive;

        if (ownerlist.length <= 1) {
            if (!owner.send(this.balance)) throw;            
        } else {
            // send incentive of 5% to previous owner
            if (!owner.send(this.balance * 19 / 20)) throw;
            if (!ownerlist[ownerlist.length - 2].send(uint(this.balance))) throw;
        }
        
        // Retrieve the current ownerchain address from the storage contract
        OwnerChain ownerchain = OwnerChain(storageContract.ownerchainAddress());
        ownerchain.bikeOwnershipTransferred(owner, msg.sender, serialNumber);

        owner = acknowledgedBuyer;
        ownerlist.push(owner);
        acknowledgedBuyer = address(0);
    }

    /// Direct transfer of ownership without no payment
    function transferOwnership(address to)
    	onlyOwner
    {
    	ownershipTransferred();

    	owner = to;
    	ownerlist.push(to);

        OwnerChain ownerchain = OwnerChain(storageContract.ownerchainAddress());
        ownerchain.bikeOwnershipTransferred(msg.sender, to, serialNumber);
    }

    /// Get essential values for buyer 
    function getBuyDetails() constant returns (address _ownerAddr, address _acknowledgedBuyerAddr, uint _requestedValue) {
        return (owner, acknowledgedBuyer, requestedValue);
    }

}