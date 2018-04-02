#!/bin/bash
echo "-------------This is my customScript in docker--------------------\n"
echo "---------------i cat a file present in the dirinuri zip. see dirinuri line of iexec.js------------------\n"
cat text.txt
echo "---------------find image present in the dirinuri zip .see dirinuri line of iexec.js------------------\n"
ls *.png
echo "--------------just echo your param you give me in cmdline of iexec.js-------------------\n"
echo $1
echo "-------------cat /iExec/MyFileIniExecDir.txt --------------------\n"
cat /iExec/MyFileIniExecDir.txt
touch seeYouInMyZip.txt
