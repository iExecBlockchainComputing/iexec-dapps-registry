#!/bin/bash
echo "-------------This is my customScript in docker--------------------\n"
echo "---------------i cat a file. see dirinuri of iexec.js------------------\n"
cat text.txt
echo "--------------just echo your param you give me in cmdline of iexec.js-------------------\n"
echo $1
echo "-------------cat MyFile.txt--------------------\n"
cat MyFile.txt
echo "-------------cat /iExec/MyFileIniExecDir.txt --------------------\n"
cat /iExec/MyFileIniExecDir.txt

