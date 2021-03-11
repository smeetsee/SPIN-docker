# This file is a template, and might need editing before it works on your project.
FROM ubuntu:focal
MAINTAINER Xander Smeets <xander@smeets.re>

ARG DEBIAN_FRONTEND=noninteractive

ADD 01-nodoc.conf /etc/dpkg/dpkg.cfg.d/01-nodoc

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get remove -y --purge libzmq-dev python-dev \
 && apt-get remove -y --purge cpp binutils \
 && apt-get -y install \
        software-properties-common \
 && apt-get -y install \
        git \
        wget \
        make \
        gcc \
        bison \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

 RUN git clone https://github.com/nimble-code/Spin.git \
 &&     rm -rf Spin/bin \
 &&     cd Spin/Src \
 &&     make \
 &&     mkdir -p /usr/local/share/man/man1 \
 &&     make install
 &&     cd ../.. \
 &&     rm -rf Spin

VOLUME ["/data"]
WORKDIR /data
