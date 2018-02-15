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
echo "i cat a file present in the docker image in /host"
cat /host/MyFileInTheImageInHost.txt
echo "---------------------------------\n"
echo "---------------------------------\n"
echo "i cat a file present in the docker image in /tmp"
cat /tmp/MyFileInTheImageInTmp.txt
echo "---------------------------------\n"
echo "i cat a file MyFileInTheImageInRoot.txt"
cat MyFileInTheImageInRoot.txt
echo "---------------------------------\n"
echo "i cat a file /iExec/MyFileInTheImageInRoot.txt"
cat /iExec/MyFileInTheImageInRoot.txt
echo "---------------------------------\n"
echo "---------------------------------\n"
echo "i cat a file /iExec/MyFileInTheImageIniExec.txt"
cat /iExec/MyFileInTheImageIniExec.txt
echo "---------------------------------\n"
echo "ls:"
ls
echo "---------------------------------\n"
echo "find:"
find -name MyFileInTheImage.txt .