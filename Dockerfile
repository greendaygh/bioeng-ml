FROM ubuntu:18.04
USER root

## packages
RUN apt-get update --fix-missing \
    && apt-get install -y -qq --no-install-recommends sudo vim locales cmake \
		build-essential net-tools gcc g++ openssl libgl1-mesa-glx wget \ 
		bzip2 ca-certificates curl git pciutils unzip ssl-cert xzdec \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8 LC_ALL=ko_KR.UTF-8

RUN wget --no-check-certificate https://curl.haxx.se/ca/cacert.pem \
    && cp cacert.pem /usr/lib/ssl/certs \
    && c_rehash /usr/lib/ssl/certs

## miniconda installation
RUN curl -sSLk https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -u -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh 

## conda package installation
RUN conda update --all \
	&& conda config --set ssl_verify no \
    && conda config --add channels conda-forge \
    && conda config --add channels anaconda \
    && conda config --add channels bioconda \
    && conda config --add channels biobuilds \
    && conda install -y tensorflow=1.14 numpy=1.16.4 lightgbm biopython jupyterlab pandas \
    && conda install -y matplotlib blast scikit-learn \
    && conda install -y openssl certifi cffi scikit-image \
    && conda install -y seaborn dask pycryptodomex keras \
    && conda install -y clustalw meme hyperopt theano xlrd openpyxl 


ENV PATH /opt/conda/bin:$PATH

## clean
RUN apt-get autoremove -y \
    && apt-get clean \
    && conda clean -i -t -y \
    && rm -rf /usr/local/src/*

## add alias 
RUN echo "alias ll='ls -al'" >> ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH

WORKDIR /home/bioengml/


