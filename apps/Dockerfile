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
# -----------------
# ethcc-tuto-step-3
# -----------------
RUN apt-get install -y software-properties-common
RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update -qq
RUN apt-get install -y r-base
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN R -e 'install.packages("jsonlite",  repos="http://cran.rstudio.com/")'
RUN R -e 'install.packages("tibble",  repos="http://cran.rstudio.com/")'
RUN R -e 'install.packages("dplyr",  repos="http://cran.rstudio.com/")'
RUN R -e 'install.packages("ggplot2",  repos="http://cran.rstudio.com/")'
