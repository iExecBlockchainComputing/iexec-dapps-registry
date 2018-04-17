#!/bin/bash
echo "-------------This is my customScript in docker--------------------\n"
echo "---------------i cat a file present in the dirinuri zip. see dirinuri line of iexec.js------------------\n"
cat /iexec/text.txt
echo "---------------find image present in the dirinuri zip .see dirinuri line of iexec.js------------------\n"
ls /iexec/*.png
echo "--------------just echo your param you give me in cmdline of iexec.js-------------------\n"
echo $1
echo "-------------cat /app/MyFileIniExecDir.txt --------------------\n"
cat /app/MyFileIniExecDir.txt

echo "------------- launch scriptAtRoot.sh --------------------\n"
bash scriptAtRoot.sh
echo "-------------generate result --------------------\n"
touch /iexec/seeYouInMyZip.txt
touch /DoNOTseeYouInMyZip.txt
