# Salary Estimator dApp

This is a decentralized application (dApp) that predicts the salary of a job based on a dataset. The dApp is designed to run on the iExec platform and uses trusted execution 
environments (TEEs) to ensure that the computation is secure and private.


⚠️ This app was made in order to test the iExec stack, it's a POC. 



## How to build, deploy and run from scratch


In the following steps you will need :
 - An account on the registry https://hub.docker.com/ to be able to push your image
 - An account on https://sconedocs.github.io/registry/ to retrieve an image to sconify your application

Once the 2 accounts are created and activated, don't forget to make a docker login for these 2 registries

In addition, you will need the iExec CLI. For that follow the official documentation here https://docs.iex.ec/for-developers/quick-start-for-developers and once the installation is done, initialize a wallet:

``` Shell
iexec wallet create
```


### Clone this repo and init 

``` Shell
git clone git@github.com:thewhitewizard/salary-estimator.git
cd salary-estimator
iexec init --skip-wallet
```

### Build the App 

This module is written in Golang. A devcontainer is provided with the project making the developpement easy, but it is only if you need to modify the application sources.

**Step 1: Build and push the docker image**

``` Shell
docker build -t <dockerusername>/salary-estimator:X.Y.Z .
```

In order to benefit from the computation confidentiality offered by Trusted Execution Environnements, we will use the scon technology (https://docs.iex.ec/for-developers/confidential-computing/create-your-first-sgx-app)

Modified line 4 of the sconfiy.sh script to indicate your user name on the docker hub, and line 6 to indicate your tag 

After, you can execute 
``` Shell
./sconify.sh    
```

Now you can push the app :
``` Shell
docker push <dockerusername>/salary-estimator:X.Y.Z-tee-debug
```


### Configuration and deploy

``` Shell
iexec app init --tee
iexec storage init --chain bellecour --tee-framework scone
```

according to the documentation , you have to get the fingerprint of your image and the fingerprint of the enclave


``` Shell
# mrenclave fingerprint
docker run -it --rm -e SCONE_HASH=1 <dockerusername>/salary-estimator:X.Y.Z-tee-debug 

#docker image fingerprint
docker pull  <dockerusername>/salary-estimator:X.Y.Z-tee-debug | grep "Digest: sha256:" | sed 's/.*sha256:/0x/' 
```

Edit iexec.jon and update values for *multiaddr, checksum and fingerprint*

Great, now you are ready to deploy
``` Shell
iexec app deploy --chain bellecour
```





### Dataset

The dataset used will be encrypted (https://docs.iex.ec/for-developers/confidential-computing/sgx-encrypted-dataset) and the decryption key stored via the SMS component. Only the dApp has the authorization to access the decrypted dataset.


The dataset is a simple CSV file with no headers and comma separator:

```
job;number of years of experience, city, education, salary
```

It is important to respect this format if you do not want to modify the sources

Sample :

```
DEVOPS,2,PROVINCE,SELF-TAUGHT,33948
CLOUD_ARCHITECT,2,PARIS,ENGINEERING_SCHOOL,54450
```

To make the dataset available to the dApp, follow the steps described here https://docs.iex.ec/for-developers/confidential-computing/sgx-encrypted-dataset

An extract of the complete dataset is available in this repo as an sample


### Run this dApp

To make the prediction, the dApp expects the name of the desired job, the location, the level of study and finally the number of years of experience.
All this inputs must be set as requester secret.


``` Shell
# push all secrets to the SMS
iexec requester push-secret my-job --chain bellecour
iexec requester push-secret my-city --chain bellecour
iexec requester push-secret my-education --chain bellecour
iexec requester push-secret my-experience --chain bellecour

# check secrets are available on the SMS
iexec requester check-secret my-job --chain bellecour
iexec requester check-secret my-city --chain bellecour
iexec requester check-secret my-education --chain bellecour
iexec requester check-secret my-experience --chain bellecour
```


For example for a nodejs developer job, in Paris with a bachelor level and 14 years of experience, you can set 

```
DEV_NODEJS PARIS BACHELOR 14
```


Now to run the app juste execute

``` shell
exec app run 0xe09915E89Ba50f1C7F7EaA302745A7F8fD5Ea110 --secret 1=my-job --secret 2=my-city --secret 3=my-education --secret 4=my-experience  --tag tee,scone --dataset 0x4850b6e663A079F0022eC6D66EaE75FDe67d593f --watch
```

⚠️ You must respect the assignment of the secrets, i.e. secret 1 is always the job, secret 2 the city, secret 3 the degree and finally secret 4 the number of years of experience 


Sample of output :

``` shell
Using chain bellecour [chainId: 134]
? Using wallet UTC--2023-02-21T10-37-09.156000000Z--6c1b288403eB6396aCed25063b2942A7448c594D
Please enter your password to unlock your wallet [hidden]
ℹ Using app 0xe09915E89Ba50f1C7F7EaA302745A7F8fD5Ea110
ℹ Creating apporder
ℹ Using dataset 0x4850b6e663A079F0022eC6D66EaE75FDe67d593f
ℹ Creating datasetorder
ℹ Using workerpool debug-v8-bellecour.main.pools.iexec.eth
ℹ Fetching workerpoolorder from iExec Marketplace
ℹ Creating requestorder
? Do you want to spend 0.0 RLC to execute the following request: 
app:        0xe09915E89Ba50f1C7F7EaA302745A7F8fD5Ea110 (0.0 RLC)
dataset:    0x4850b6e663A079F0022eC6D66EaE75FDe67d593f (0.0 RLC)
workerpool: 0xdb214a4A444D176e22030bE1Ed89dA1b029320f2 (0.0 RLC)
params: 
  iexec_result_storage_provider: ipfs
  iexec_result_storage_proxy:    https://result.v8-bellecour.iex.ec
  iexec_secrets: 
    1: my-job
    2: my-city
    3: my-education
    4: my-experience
category:   0
tag:        0x0000000000000000000000000000000000000000000000000000000000000003
 Yes
ℹ Deal submitted with dealid 0x3e6691fde07eddc1f85ee5f5b7d42961a092c1bb15744fa93a1a103bfecae123
✔ App run successful:
1/1 tasks completed:
- Task idx 0 (0x1f7a2db96bc79aa0c4b70842f9e280d81235fde307188f640fb463e087b71c0f)
```


### Download the result

From the previous task id

``` shell
iexec task show 0x1f7a2db96bc79aa0c4b70842f9e280d81235fde307188f640fb463e087b71c0f --download my-app-result
``` 

Unzip result file

``` shell
unzip my-app-resuxxxlt.zip             
```

Display the result and you can go negotiate with your boss 😃

``` shell
❯ cat result.txt
you can expect a salary of 83835
```

