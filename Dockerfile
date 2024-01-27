FROM ubuntu:jammy

LABEL org.opencontainers.image.authors="wjtcw@hotmail.com"

# Install basic packages
RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    gcc \
    gfortran \
    git \
    sudo \
    wget

# Set up user
ARG USER=bart
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/$USER
RUN chown -R $USER:$USER /home/$USER


# Change to user bart
USER $USER
WORKDIR $HOME

# dealii dependencies
RUN sudo apt-get install -y \
    make \
    libfftw3-dev \
    liblapacke-dev \
    libpng-dev \
    libopenblas-dev

RUN git clone https://github.com/mrirecon/bart.git

USER root
RUN sh -x  && \
    cd /home/bart/bart && \
    make && \
    make install
