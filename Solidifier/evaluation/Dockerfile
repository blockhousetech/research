FROM ubuntu:18.04

RUN mkdir /scripts

#INSTALL SOLIDIFIER

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

## INSTALL SOLC-VERIFY
#### Boogie install
RUN git clone https://github.com/boogie-org/boogie.git
RUN cd boogie && git checkout 9e74c3271f430adb958908400c6f6fce5b59000a && wget https://nuget.org/nuget.exe && mono ./nuget.exe restore Source/Boogie.sln && xbuild Source/Boogie.sln

#### solc-verify itself
RUN apt install python3-pip -y
RUN pip3 install psutil
RUN git clone https://github.com/SRI-CSL/solidity.git
RUN cd solidity && git checkout v0.5.16-solc-verify && ./scripts/install_deps.sh && mkdir build && cd build/ && cmake -DBOOGIE_BIN="/boogie/Binaries/" .. && make
RUN ln -s /z3-Z3-4.8.5/build/z3 /usr/local/bin/z3

## INSTALL MYTHRIL
RUN apt-get install libssl-dev -y
RUN pip3 install mythril

## INSTALL VERISOL
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install apt-transport-https -y
RUN apt-get update
RUN apt-get install dotnet-sdk-2.2 -y
RUN dotnet tool install VeriSol --version 0.1.1-alpha --global
RUN ~/.dotnet/tools/VeriSol C.sol C; exit 0 # First run install z3, boogie and corral for it

ENV PATH=/scripts:${PATH}
ENV SOLC=/solidity_0.4.26/build/solc/solc

COPY Solidifier /scripts
COPY examples /examples
COPY examples_0.5.10/ /examples_0.5.10
COPY examples_mythril/ /examples_mythril

COPY run_examples.sh /
COPY run_examples_with_solc-verify.sh /
COPY run_examples_with_verisol.sh /
COPY run_examples_with_mythril.sh /
