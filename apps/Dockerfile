FROM r-base
RUN apt-get update
RUN apt-get install -y libapparmor-dev
RUN apt-get install -y libpoppler-cpp-dev
RUN apt-get install -y libpoppler-glib-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libgeos-dev
RUN apt-get install -y libwebp-dev 
RUN R -e 'install.packages("tm", dependencies = TRUE)'
RUN R -e 'install.packages("pdftools", dependencies = TRUE)'
RUN R -e 'install.packages("wordcloud", dependencies = TRUE)'
RUN R -e 'install.packages("RColorBrewer", dependencies = TRUE)'

