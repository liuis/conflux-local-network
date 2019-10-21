#FROM daocloud.io/ubuntu:trusty
FROM ubuntu:16.04
#FROM gcc:latest
#FROM rust:1.31
MAINTAINER ping.li <ping.li@conflux-chain.org>

#RUN cargo install --path .

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y git \
                       curl \
                       cmake \
                       protobuf-compiler
RUN set -x && \  
    add-apt-repository ppa:ethereum/ethereum  && \
    apt-get update && \ 
    apt-get install -y python \
                       python-dev \
                       python-pip  \
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

RUN git clone https://github.com/Conflux-Chain/conflux-rust.git  && \
    cd conflux-rust && \ 
    var currVersion = git checkout `git describe --tags `git rev-list --tags --max-count=1` && \
    git checkout $currVersion 
    # build in release mode
#RUN which cargo
#RUN export PATH="$PATH:$HOME/.cargo/bin" >> $HOME/.bashrc
#RUN source $HOME/.bashrc
RUN cd conflux-rust && $HOME/.cargo/bin/cargo -V &&  $HOME/.cargo/bin/cargo update && $HOME/.cargo/bin/cargo build --release && \ 
    # start test case 
    ./dev-support/dep_pip3.sh && \ 
    ./dev-support/test.sh  && \ 
#WORKDIR conflux-rust 
#EXPOSE 80
CMD ["bash"]
