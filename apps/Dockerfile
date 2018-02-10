FROM r-base
RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y libmariadbclient-dev

RUN R -e 'install.packages("Rcpp", dependencies = TRUE)'
RUN R -e 'install.packages("ggplot2", dependencies = TRUE)'
RUN R -e 'install.packages("dplyr", dependencies = TRUE)'





