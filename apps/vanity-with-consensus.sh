#!/bin/bash

vanityResult=stdout.txt
consensusFile=consensus.iexec

vanitygen $@ >> $vanityResult
cat $vanityResult

vanityPattern=$(grep 'Pattern:' $vanityResult | sed 's/^.*: //')
publicAddress=$(grep 'Address: '$vanityPattern $vanityResult | sed 's/^.*: //')

publicAddressLength=${#publicAddress}

rm -f $consensusFile
echo $vanityPattern >> $consensusFile
echo $publicAddressLength >> $consensusFile
