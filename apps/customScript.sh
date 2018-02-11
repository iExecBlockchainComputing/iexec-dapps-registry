#!/bin/bash
echo "---------------------------------\n"
echo "This is my customScript in docker"
echo "---------------------------------\n"
echo "i cat a file. see dirinuri of iexec.js"
cat text.txt
echo "---------------------------------\n"
echo "just echo your param you give me in cmdline of iexec.js"
echo $1
echo "---------------------------------\n"
echo "i cat a file present in the docker image"
cat MyFileInTheImage.txt
echo "---------------------------------\n"