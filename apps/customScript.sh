#!/bin/bash
echo "----------------------Inside the docker----------------------------"

unzip contracts.zip -d /oyente

echo "-------------------------Unzipped----------------------------------"

num=( $(find contracts -type f|wc -l) )

echo ${num}

arr=( $(find contracts -type f) )

i=0

while (($i <= $num-1)); do
    echo $i
    python oyente/oyente.py -s ${arr[i]} -ce
    ((i++))
done

rm contracts.zip

rm -rf contracts
echo "-----------------------------Done---------------------------------"

