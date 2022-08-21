FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes --fix-missing \
        bison \
        build-essential \
        bzip2 \
        ccache \
        checkinstall \
        cmake \
        curl \
        flex \
        g++ \
        gcc \
        gettext \
        ghostscript \
        git \
        grass \
        grass-dev \
        grass-doc \
        libboost-program-options-dev \
        libboost-thread-dev \
        libbz2-dev \
        libcairo2 \
        libcairo2-dev \
        libfftw3-3 \
        libfftw3-dev \
        libfreetype6-dev \
        libgcc1 \
        libgeos-dev \
        libglu1-mesa-dev \
        libgsl-dev \
        libncurses5-dev \
        libpdal-dev \
        libpnglite-dev \
        libpq-dev \
        libproj-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libtiff5-dev \
        libwxbase3.0-dev   \
        libwxgtk3.0-gtk3-dev \
        libxmu-dev \
        libzstd-dev \
        make \
        proj-bin \
        proj-data \
        python3 \
        python3-dateutil \
        python3-dev \
        python3-distutils \
        python3-numpy \
        python3-opengl \
        python3-pip \
        python3-wxgtk4.0 \
        sqlite3 \
        subversion \
        unzip \
        wget \
        wx-common \
        wx3.0-headers \
        zlib1g-dev 

RUN echo 'alias python=python3' >> ~/.bashrc

COPY requirements.txt ./

RUN pip install cython && \
    pip install -r requirements.txt

RUN wget --no-check-certificate \
        http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz && \
    tar xzf mpich-3.2.1.tar.gz && \
    cd mpich-3.2.1 && \
    ./configure --prefix=/usr/local --disable-fortran && \ 
    make -j$(nproc) && \
    make install

RUN cd /usr/local && \
    git clone https://github.com/amoodie/TauDEM.git && \
    cd TauDEM && \
    git checkout amoodie-inunmap && \
    cd src && mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install && \
    echo 'export PATH=/usr/local/TauDEM/src/build:$PATH' >> ~/.bashrc
