FROM ubuntu:trusty
RUN apt-get update
COPY customScript.sh /usr/bin/customScript.sh
RUN chmod 755 /usr/bin/customScript.sh
COPY scriptAtRoot.sh scriptAtRoot.sh
RUN chmod 755 scriptAtRoot.sh
COPY fileAtRoot.txt fileAtRoot.txt
COPY MyFileInAppDir.txt /app/MyFileInAppDir.txt

RUN mkdir /iexec
