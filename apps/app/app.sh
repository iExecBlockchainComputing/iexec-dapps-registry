#!/bin/bash
cd /app/jsApp
#node extractTokenTransfer.js SMART_CONTRACT_ADDRESS NB_TX_LIMIT NODE_TARGET
node extractTokenTransfer.js $1 $2 $3
cd -
