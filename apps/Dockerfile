FROM ubuntu:trusty
# ----
# init
# ----
RUN apt-get update
RUN mkdir /host
RUN apt-get install -y git curl
COPY app app
RUN chmod +x /app/app.sh
# -----------------
# ethcc-tuto-step-2
# -----------------
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN cd /app/jsApp && npm install
