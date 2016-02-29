FROM debian:jessie

MAINTAINER Marc Sola Nadal <marcsolanadal@gmail.com>

RUN apt-get update && apt-get install -y \

    build-essential \
    sudo \
    curl \
    git-core \

    # neovim dependencies
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    libmsgpack-dev \
    libuv-dev \
    libluajit-5.1-dev \

 && rm -rf /var/lib/apt/lists/*

# Installing Node
#RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
#RUN apt-get install -y nodejs

# Setup home environment
RUN useradd -g sudo dev
RUN echo "dev:docker!" | chpasswd
RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/bin
#RUN mkdir -p /home/dev/node /home/dev/bin /home/dev/lib /home/dev/include
ENV PATH /home/dev/bin:$PATH
#ENV PKG_CONFIG_PATH /home/dev/lib/pkgconfig
#ENV LD_LIBRARY_PATH /home/dev/lib
#ENV NODE_PATH /home/dev/node:$NODE_PATH

WORKDIR /home/dev
ENV HOME /home/dev
#COPY gitconfig /home/dev/.gitconfig

# nvim
RUN git clone https://github.com/neovim/neovim.git
WORKDIR /home/dev/neovim
RUN make
RUN cp /build/bin/nvim $HOME/bin

WORKDIR $HOME

# Installing node
#RUN curl -O https://nodejs.org/dist/v5.7.0/node-v5.7.0.tar.gz
#RUN tar xvfz node-v5.7.0.tar.gz
#
#RUN git clone https://github.com/marcsolanadal/.dotfiles

# Link in shared parts of the home directory
# RUN ln -s /var/shared/.ssh
# RUN ln -s /var/shared/.bash_history
# RUN ln -s /var/shared/.maintainercfg

run chown -R dev: /home/dev
user dev
