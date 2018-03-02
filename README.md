# iExec dapps registry
## 1 branch = 1 dapp

## How to add my dapp to the iExec dapps registry?

To create your own iExec dapp, use the [iExec sdk cli](https://github.com/iExecBlockchainComputing/iexec-sdk) to [init](https://github.com/iExecBlockchainComputing/iexec-dapps-registry/tree/init) a new project:
```bash
iexec init
```

Then, edit with care both ```iexec.js``` and ```package.json```:

```js
// iexec.js
{
  name: '', // project name
  app: {}, // app description
  work: {} // work description
}
```
```json
// package.json
{
  "name": "?",
  "version": "?",
  "description": "?",
  "author": {
    "name": "?"
  },
  "license": "?",
  "homepage": "?",
  "logo": "?"
}
```
After running ```iexec deploy```, commit these files/folders:
 * ```iexec.js```
 * ```package.json```
 * ```./contracts/```
 * ```./build/contracts/name.json```
 * ```./apps/```

Finally, start a [Pull Request](https://github.com/iExecBlockchainComputing/iexec-dapp-samples/pulls) to add your dapp to this repo.

## How to be listed on the [iExec dapp store](https://dapps.iex.ec/)?

Once your dapp is merged into this repo, next step is to submit a pull request to the [iExec dapp store DB repository](https://github.com/iExecBlockchainComputing/iexec-dapps-store-db).
