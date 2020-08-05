FROM ubuntu:latest

MAINTAINER

COPY . /intrigue
 
RUN wget https://cran.r-project.org/src/base/R-3/R-3.4.4.tar.gz && tar -xf R-3.4.4.tar.gz && rm R-3.4.4.tar.gz \
   && cd R-3.4.4 && ./configure --with-x=no && cd src/nmath/standalone && make
ENV RMATH /R-3.4.4/src

RUN apt-get -y update -qq \
 && apt-get install -y --no-install-recommends \
     libgs10-dev \
 && R -e "devtools::install_dev_deps('/intrigue',dep=TRUE)" \
 && R -e "install.packages('SQUAREM',repos='https://cran.rstudio.com/')" \
 && R -e "install.packages('stats', repos='https://cran.rstudio.com/')" \
 && R -e "install.packages('rlist', repos='https://cran.rstudio.com/')"
