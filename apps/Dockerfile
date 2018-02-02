FROM r-base
RUN apt-get update
RUN apt-get install -y libapparmor-dev
RUN apt-get install -y libpoppler-cpp-dev
RUN apt-get install -y libpoppler-glib-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libgeos-dev
RUN apt-get install -y libwebp-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y curl
RUN apt-get install -y libmagic-dev
RUN apt-get install -y libssl-dev


RUN R -e 'install.packages("tm", dependencies = TRUE)'
RUN R -e 'install.packages("pdftools", dependencies = TRUE)'
RUN R -e 'install.packages("wordcloud", dependencies = TRUE)'
RUN R -e 'install.packages("RColorBrewer", dependencies = TRUE)'
RUN R -e 'install.packages("RCurl", dependencies = TRUE)'
RUN R -e 'install.packages("drat", dependencies = TRUE)'
RUN R -e 'drat::addRepo("RInstitute")' -e 'install.packages("dqmagic", dependencies = TRUE)'





