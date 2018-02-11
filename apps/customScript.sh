#!/bin/bash
echo "---------------------------------"
echo "This is my customScript in docker"
echo "---------------------------------"
echo "i cat a file. see dirinuri of iexec.js"
cat text.txt
echo "---------------------------------"
echo "just echo your param you give me in cmdline of iexec.js"
echo $1
echo "---------------------------------"