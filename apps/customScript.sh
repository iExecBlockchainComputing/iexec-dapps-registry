#!/bin/bash
echo "----------------------Inside the docker----------------------------"

b=( $(find / -name contracts -type d) )
c=( $(find / -name oyente.py -type f) )
echo "----------------------Contracts located----------------------------"

num=( $(find $b -type f|wc -l) )

echo ${num}

arr=( $(find $b -type f) )

i=0

while (($i <= $num-1)); do
    echo $i
    python $c -s ${arr[i]} -ce
    ((i++))
done

rm -rf $b

echo "-----------------------------Done---------------------------------"

