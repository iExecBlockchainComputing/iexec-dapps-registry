# iexec Identity Proposal

## DApp Description

This Dapp allow to verify identity based on standard picture including his ID (Passport or Licence driver). Before, We trained a neural network to perform authenfication of the image.

This iexec application serves as a bridge in such an architecture, to accept a picture and return the result of the authentificatino.

## Implementation Presentation

An example workflow is described below:

* Steps:
1. User sends his identity hash (including a link to the IPFS picture) to Ethereum smart contract.

2. User sends the request to Iexec to perform the work to identifiy the validity of the identity.

3. iexec runs the query in the neural network.

4. iexec returns the result to the smart contract.

6. User can check the result of the authenfication.