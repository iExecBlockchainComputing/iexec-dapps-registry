#!/bin/bash
# -----------------
# ethcc-tuto-step-2
# -----------------
cd /app/jsApp
#node extractTokenTransfer.js SMART_CONTRACT_ADDRESS NB_TX_LIMIT NODE_TARGET
node extractTokenTransfer.js $1 $2 $3
cd -
# -----------------
# ethcc-tuto-step-3
# -----------------
if [ -f /host/transferTransactions.json ]
then
cd /app/RScriptApp
Rscript /app/RScriptApp/analyseTransferTransactions.r
cd -
fi
