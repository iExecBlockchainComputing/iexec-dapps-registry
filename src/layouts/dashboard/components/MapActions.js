import SupplyChainContract from '../../../../build/contracts/SupplyChain.json';
import ShipmentContract from '../../../../build/contracts/Shipment.json';
import GoodsManagementContract from '../../../../build/contracts/GoodsManagement.json';
import PropertyContract from '../../../../build/contracts/Property.json';

import store from '../../../store';

export function getChain() {

    let web3 = store.getState().web3.web3Instance

    // Double-check web3's status.
    if (typeof web3 !== 'undefined') {
  
      return function(dispatch) {
        // Using truffle-contract we create the authentication object.
        const chain = contract(ChainContract)
        chain.setProvider(web3.currentProvider)
  
        // Declaring this for later so we can chain functions on Authentication.
        var chain;
  
        // Get current ethereum wallet.
        web3.eth.getCoinbase((error, coinbase) => {
          // Log errors, if any.
          if (error) {
            console.error(error);
          }
          
          chain.deployed().then(function(instance) {
            chainInstance = instance

            chainInstance.getChain(0,{from: coinbase}).then((result) => {  // Hardcoded value (to be changed)
              
              const chainName = web3.toAscii(result[0]);
              const chainCreationTime = (new Data(parseInt(result[1])*1000)).toString();
              const  index = result[2];
              getChainData(chainName,chainCreationTime,index);

            });
          });
      });
    }

  }

}