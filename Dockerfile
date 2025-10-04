# Versões de bibliotecas baseadas no Notebook

FROM rocker/shiny:4.5.1

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libpng-dev \
    libfontconfig1-dev \
    libxt-dev \
    libjpeg-dev \
    libgdal-dev \
    cmake \
    libmagick++-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

    
# Continuar instalação de pacotes
RUN R -e "install.packages('remotes', repos='http://cran.rstudio.com/'); \
            remotes::install_version('shiny', version = '1.11.1', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('shinydashboard', version = '0.7.3', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('dplyr', version = '1.1.4', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('ggplot2', version = '3.5.2', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('maps', version = '3.4.3', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('scales', version = '1.4.0', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('RSQLite', version = '2.4.3', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('pool', version = '1.0.4', repos = 'http://cran.rstudio.com/'); \
            remotes::install_version('plotly', version = '4.11.0', repos = 'http://cran.rstudio.com/')"

RUN rm -r /srv/shiny-server/*

COPY . /srv/shiny-server/

VOLUME ["/srv/shiny-server/dados"]

EXPOSE 3838