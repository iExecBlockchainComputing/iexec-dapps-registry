# iExec Dapps Registry

In order to list your dapp on the [iExec Dapp Store](https://dapps.iex.ec/), you need to make it into the iExec Dapp Registry FIRST. But relax, it's very easy:

Once you created, deployed and published your iExec Dapp using the [iExec SDK](https://github.com/iExecBlockchainComputing/iexec-sdk), here are the 5 steps that remain to enter this registry:

## Before beginning

Make sure your app runs smoothly on iExec

Make sure your app is published on the marketplace:

- run `iexec orderbook app <appAddress>`
- if the orderbook is empty, run `iexec app publish <appAddress>` to publish an apporder

Make sure the following keys of `iexec.json` are filled:

- description: a description of your app to display in the store (at least 150 chars)
- license
- author
- additionally, if your app accept args, you can fill in `buyConf.params.iexec_args` to provide default args

## 1. Github Fork this repo

click on the github "Fork" button and `git clone` the **forked** repository on your local machine and `git checkout v8` the v8 branch.

[![github fork](./github-fork.png)](https://github.com/iExecBlockchainComputing/iexec-dapps-registry)

## 2. Create 2 new folders

Inside the `iexec-dapps-registry` folder, create:

- **One** organization folder at the root **[MUST match your github user or github org name]**. Ex: `/iExecBlockchainComputing`.

- **One** folder for your dapp inside your org folder **[MUST match your dapp name]**. Ex: `/iExecBlockchainComputing/VanityGen`.

## 3. Validate

Enter your dapp folder, and run the below command to check your config:

- `iexec registry validate app`

## 4. Commit

Once the validation is successful, you can commit & push your app config.

- `git add iexec.json deployed.json logo.png README.md`
- `git commit -m 'adding my Vanitygen app'`
- `git push`

## 5. Github Pull Request

click on this button to create a Pull Request (from your **forked v8 branch** TO **iexec-dapps-registry v8 branch**):

[![github pull request](./github-pr.png)](https://github.com/iExecBlockchainComputing/iexec-dapps-registry/compare)

One last thing... it will be helpful if you provide the taskid of a successfully executed task in the comments!

**We'll review you Dapp and if it meets all the above criteria, it will be added to the iExec Dapp Registry!**
