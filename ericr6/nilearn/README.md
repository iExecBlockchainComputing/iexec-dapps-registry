# iExec Dapps Registry

In order to list your dapp on the [iExec Dapp Store](https://dapps.iex.ec/), you need to make it into the iExec Dapp Registry FIRST. But relax, it's very easy:

Once you created and deployed your iExec Dapp using the [iExec SDK](https://github.com/iExecBlockchainComputing/iexec-sdk), here are the 5 steps that remain to enter this registry:

## 1. Github Fork this repo

clic on the github "Fork" button and `git clone` the **forked** repository on your local machine.

[![github fork](./github-fork.png)](https://github.com/iExecBlockchainComputing/iexec-dapps-registry/tree/v2#fork-destination-box)

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

clic on this button to create a Pull Request (from your **forked master branch** TO **iexec-dapps-registry master branch**):

[![github pull request](./github-pr.png)](https://github.com/iExecBlockchainComputing/iexec-dapps-registry/compare)

**We'll review you Dapp and if it meets all the above criteria, it will be added to the iExec Dapp Regsitry!**
