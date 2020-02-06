FROM ubuntu:18.04

RUN mkdir /scripts

RUN apt-get update
RUN apt-get install -y wget unzip python g++ gnupg ca-certificates lsb-core sudo
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get update
RUN apt-get install -y mono-devel

# Install solc version 0.4.26
RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.26/solidity_0.4.26.tar.gz
RUN tar -xf solidity_0.4.26.tar.gz
RUN ls
RUN cd solidity_0.4.26/ && ./scripts/install_deps.sh && mkdir build && cd build && cmake .. && make
RUN ln -s /solidity_0.4.26/build/solc/solc /scripts/solc-0.4.26

# Install z3
RUN wget https://github.com/Z3Prover/z3/archive/Z3-4.8.5.zip
RUN unzip Z3-4.8.5.zip
RUN cd z3-Z3-4.8.5/ && python scripts/mk_make.py && cd build && make

# Install Corral
RUN wget https://github.com/boogie-org/corral/archive/v1.0.1.zip
RUN unzip v1.0.1.zip

RUN wget https://github.com/boogie-org/boogie/archive/v2.4.13.zip
RUN unzip v2.4.13.zip
RUN pwd
RUN ls /corral-1.0.1/
RUN cp -r boogie-2.4.13/* /corral-1.0.1/boogie/

## Building Corral
RUN cd corral-1.0.1/ && xbuild /p:TargetFrameworkVersion=v4.5 /p:Configuration=Release cba.sln

## Linking z3
RUN ln -s /z3-Z3-4.8.5/build/z3 /corral-1.0.1/bin/Release/z3.exe

RUN echo '#!/bin/bash\n' > /scripts/corral
RUN echo 'mono /corral-1.0.1/bin/Release/corral.exe $@' >> /scripts/corral
RUN chmod +x /scripts/corral

ENV PATH=/scripts:${PATH}

COPY Solidifier /scripts
COPY examples /examples
COPY run_examples.sh /
