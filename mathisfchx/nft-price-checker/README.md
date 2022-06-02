# Golang OpenSea's NFT Collections floor price checker
<p align="center">
    <img src="./logo.png" alt="drawing" width="150" />  
</p>

Check the Opensea floor price of the NFTs you own, and calculate the total estimate of your NFT portfolio in $eth and $usd.  

### Build
First, let's build the docker image
```
docker build . --tag nft-price-checker
```

### Input
This solution reads a .json input file following this format :
```
{
    "ownerAddress": "0x_owner_address",
    "collections": [
        {
            "collectionId": "collection_id",
            "count":  number_of_asset_owned
        },
        ...
    ]
}
```
If you fill the `ownerAddress`, the dapp will directly ask Opensea for the collections and nft that you own, so you don't have to manually fill the `collections` part :
```
<input.json>
{
    "ownerAddress": "0x01234567891012345678910123456789101234567891"
}
```
**Or**, If you want to inspect specific collections (and not a 0x address), you can fill (just) the `collections` part with the Opensea collection id (or slug) and the number of assets that you own from that collection :
```
<input.json>
{
    "collections": [
        {
            "collectionId": "nft-worlds",
            "count": 2
        },
        {
            "collectionId": "psychedelics-anonymous-genesis",
            "count": 1
        },
        {
            "collectionId": "iexec-nft",
            "count": 3
        }
    ]
}
```  
The collection id can be found in the url of the Opensea Collection Page  
ie : for https://opensea.io/collection/boredapeyachtclub, the id is `boredapeyachtclub`

### Output
The dapp is compatible with either "web2" (IPFS) or "web3" (callback) output. You just have to specifiy the wanted behavior in the iexec_args.

- The web2 workflow will produce a `/iexec_out/result.txt` file following a detailled plain text format :  
```
</iexec_out/result.txt>
--> nft-worlds Floor price = 3.940000 eth
 So 2.000000*3.940000=7.880000 eth
--> psychedelics-anonymous-genesis Floor price = 1.940000 eth
 So 1.000000*1.940000=1.940000 eth
  x iexec-nft cannot be found on Opensea 
------------- 
 The estimate total value of your portfolio is : 9.820000 eth
 Or 20345.861600 Usd
```

- The web3 workflow is designed to return the Usd global estimate of your portfolio as a callback-data. Thus, there is no `result.txt` file but in the `computed.json` you will find the `"callback-data"` entry : "0x" + the hexadecimal encoded Usd estimate. (You can find the `go-ethereum/common/hexutil` documentation [here](https://pkg.go.dev/github.com/ethereum/go-ethereum@v1.10.17/common/hexutil))
```
</iexec_out/computed.json>
{ "callback-data" : "0x32303335372e363435363030" }
```

### Run
It is possible to run the application localy to test it out before deploying :
(It is needed to put an input file inside `/tmp/iexec_in/` folder)
```
rm -rf /tmp/iexec_out && \
docker run \
    -v /tmp/iexec_in:/iexec_in \
    -v /tmp/iexec_out:/iexec_out \
    -e IEXEC_IN=/iexec_in \
    -e IEXEC_OUT=/iexec_out \
    -e IEXEC_INPUT_FILE_NAME_1=input.json \
    -e IEXEC_INPUT_FILES_NUMBER=1 \
    nft-price-checker
    web2    # or web3
```
Once the execution ends, the result should be found in the folder
`/tmp/iexec_out`.
```
cat /tmp/iexec_out/result.txt
cat /tmp/iexec_out/computed.json
```

### Deploy
To deploy your app, follow the instructions on the IExec Documentation : https://docs.iex.ec/for-developers/your-first-app

Then, you can run your dApp with the `iexec app run` command (you can add as much parameters and options as you want, follow the SDK and CLI documentation to do so) :  
```
iexec app run --watch
```

### Confidential Computing and TEE
In order to benefit from the computation confidentiality offered by Trusted Execution Environnements, we first need to sconify our dApp.  

To do that, just run the following : 
```
./sconify.sh
```
It will build a sconified docker image of the app, that you can deploy the same way as a Standard dApp (like you did before following the iExec documentation).  
The code will now run inside a private enclave.  

You just have to add the `--tag tee` option in your run command :
```
iexec app run --watch --tag tee
```

But moreover, you can also add layer of confidentiality by protecting your input and output data.

### Datasets
Following [this documentation](https://docs.iex.ec/for-developers/confidential-computing/sgx-encrypted-dataset), you will be able to encrypt your input file and then give your "secret" (encryption key) to the SMS (Secret Management Service). Like this, no one (except you) will be able to read what your input data is.

### End to End Encryption
Finally, in order to achieve End-to-End encryption, you can encrypt your result following [this documentation](https://docs.iex.ec/for-developers/confidential-computing/end-to-end-encryption)
