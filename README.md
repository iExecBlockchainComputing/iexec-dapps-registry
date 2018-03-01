# iExec dapp samples
## 1 branch = 1 dapp
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

Finally, start a [Pull Request](https://github.com/iExecBlockchainComputing/iexec-dapp-samples/pulls) to add you dapp to this repo.

This is the **FIRST** step toward being listed on the [iExec dapp store](https://dapps.iex.ec/).
