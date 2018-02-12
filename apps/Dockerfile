FROM ubuntu:trusty
RUN apt-get update
COPY customScript.sh /usr/bin/customScript.sh
RUN chmod 755 /usr/bin/customScript.sh
COPY MyFileInTheImageInTmp.txt /tmp/MyFileInTheImageInTmp.txt
RUN chmod 755 /tmp/MyFileInTheImage.txt
COPY MyFileInTheImageInHost.txt /host/MyFileInTheImageInTmp.txt
RUN chmod 755 /host/MyFileInTheImageInTmp.txt
