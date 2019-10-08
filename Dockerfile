#FROM daocloud.io/ubuntu:trusty
FROM ubuntu:16.04
#FROM rust:1.31
MAINTAINER ping.li <ping.li@conflux-chain.org>

#RUN cargo install --path .
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN set -x && \  
    add-apt-repository ppa:ethereum/ethereum  && \
    apt-get update && \ 
    apt-get install -y python \
                       python-dev \
                       python-pip  \
                       clang \
                       libsqlite3-dev \ 
                       solc && \ 
    apt-get clean && \ 
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   && \
    curl https://sh.rustup.rs -sSf | sh  && \
    # download Conflux code
    git clone https://github.com/Conflux-Chain/conflux-rust.git  && \
    cd conflux-rust && \ 
    git checkout v0.1.8 && \ 
    # build in release mode
    cargo build --release && \ 
    # start test case 
    ./dev-support/dep_pip3.sh && \ 
    ./dev-support/test.sh  && \ 
#WORKDIR conflux-rust 
#EXPOSE 80
CMD ["bash"]
