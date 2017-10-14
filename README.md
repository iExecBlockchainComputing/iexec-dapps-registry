# iexec IPFS Database Bridge

Storing a significant number of records on the Ethereum blockchain is prohibitively expensive due to the gas costs per byte and is a big challange that often hinders the development of applications that need to create, read, update, and delete various kinds and numbers of records. 
Although iexec does not deal directly with data storage, it can serve as a middleware-type componenet that can bridge the blockchain with storage protocols such as IPFS.

As IPFS can store any kind of file, it is capable of storing file-based database files such as SQLite file to allow for storage of entire databases and retrieval of such databases on demand.

This iexec application serves as a bridge in such an architecture, to accept query requests, find the relevant DB on IPFS, run quries on the DB, and return the results to the smart contract developer in the form of an IPFS hash. 

An example workflow is described below:

* Pre-requisites: 
	* User has previously created a SQLite DB and placed the db file on IPFS, and so also has a hash of this database.
	* User has developed queries and has also stored such queries on IPFS, and so also has the hashes associated to these queries.

* Steps:
1. User sends DB Hash of SQLite DB on IPFS to Ethereum smart contract:
Example DB Hash: e0d123e5f316bef78bfdf5a008837577 

2. User sends INSERT, SELECT, UPDATE, OR DELETE query hash to Ethereum smart contract for running it on the SQLite DB:
Example Query Hash: a09455733316bef78bfdf5a498576332 

3. Upon user request, Ethereum Smart Contract sends query request along with DB hash and query hash to iexec

4. iexec does the work of downloading the database from IPFS using the DB file hash, as well as downloading the full query text from IPFS using the query hash 

5. iexec runs the query on the downloaded database

6. iexec gets the results of the query and stores the results on IPFS. Also, stores update database back to IPFS if applicable.

7. iexec returns the result to the smart contract in the form on an IPFS hash. Also, iexec returns the updated DB hash to the smart contract if the database was updated.

8. User can see the query results by using the results hash see full results stored on IPFS

<br>


![alt text](https://github.com/ZeroPointThree17/iexec-dapp-samples/blob/dapp-challenge/images/iexec-ipfs-db-bridge.png?raw=true "iexec IPFS Database Bridge")
