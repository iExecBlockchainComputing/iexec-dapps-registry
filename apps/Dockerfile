FROM ubuntu:trusty
RUN apt-get update
COPY customScript.sh /usr/bin/customScript.sh
RUN chmod 755 /usr/bin/customScript.sh

WORKDIR /iExec


COPY MyFileInTheImageInTmp.txt /tmp/MyFileInTheImageInTmp.txt
RUN chmod 755 /tmp/MyFileInTheImageInTmp.txt
COPY MyFileInTheImageInHost.txt /host/MyFileInTheImageInHost.txt
RUN chmod 755 /host/MyFileInTheImageInHost.txt

COPY MyFileInTheImageInRoot.txt MyFileInTheImageInRoot.txt
RUN chmod 755 MyFileInTheImageInRoot.txt

COPY MyFileInTheImageInIexec.txt /iExec/MyFileInTheImageIniExec.txt
RUN chmod 755 /iExec/MyFileInTheImageIniExec.txt



