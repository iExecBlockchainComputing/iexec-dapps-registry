FROM ubuntu:trusty
RUN apt-get update
COPY customScript.sh /usr/bin/customScript.sh
RUN chmod 755 /usr/bin/customScript.sh
COPY MyFileInTheImage.txt /host/MyFileInTheImage.txt
RUN chmod 755 /host/MyFileInTheImage.txt
