#ROM daocloud.io/ubuntu:trusty
FROM ubuntu:16.04
#FROM gcc:latest
#FROM rust:1.31
MAINTAINER ping.li <ping.li@conflux-chain.org>

#RUN cargo install --path .
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y git \
                       curl \
                       cmake \
                       protobuf-compiler \
                       pkg-config \
                       libssl-dev \
                       tree
RUN set -x && \  
    add-apt-repository ppa:ethereum/ethereum  && \
    apt-get update && \ 
    apt-get install -y python3 \
                       python3-dev \
                       python3-pip  \
                       clang \
                       libsqlite3-dev \ 
                       solc  
    #apt-get clean && \ 
    #apt-get autoclean && \
    #rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   && \
COPY rustup-init.sh /usr/bin/rustup-init.sh
RUN chmod +x /usr/bin/rustup-init.sh
#CMD ["rustup-init.sh"]
RUN /usr/bin/rustup-init.sh -y
    #curl -y https://sh.rustup.rs -sSf | sh  && \
    # download Conflux code
ENV PATH="$HOME/.cargo/bin:${PATH}"
#ARG CURRVERSION = git checkout `git describe --tags `git rev-list --tags --max-count=1`  

RUN git clone -b master --single-branch --depth 1 https://github.com/Conflux-Chain/conflux-rust.git  
      
    #var currVersion = git checkout `git describe --tags `git rev-list --tags --max-count=1` && \
    # build in release mode
#RUN which cargo
#RUN export PATH="$PATH:$HOME/.cargo/bin" >> $HOME/.bashrc
#RUN source $HOME/.bashrc
RUN cd conflux-rust && $HOME/.cargo/bin/cargo -V &&  $HOME/.cargo/bin/cargo update && $HOME/.cargo/bin/cargo build --release  

    # start test case 
#    ./dev-support/dep_pip3.sh && \ 
#    ./dev-support/test.sh  && \ 
RUN  apt-get install python3-pip
RUN  pip3 install ecdsa
RUN  pip3 install pysha3

WORKDIR conflux-rust 
COPY conflux.conf ./run/ 

COPY wallet-generator.py ./run/

RUN  ./run/wallet-generator.py

COPY start.sh . 

RUN tree -L 2 
EXPOSE 14629 
EXPOSE 19629 
EXPOSE 12537 
CMD ["./start.sh"]
