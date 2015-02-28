FROM ubuntu:14.04.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y

### Lagopus vswitch installation w/o Intel DPDK
RUN apt-get install -y build-essential libexpat-dev libgmp-dev libncurses-dev \
	libssl-dev libpcap-dev byacc flex libreadline-dev \
	python-dev python-pastedeploy python-paste python-twisted git
WORKDIR /root
RUN git clone https://github.com/lagopus/lagopus.git
WORKDIR /root/lagopus
RUN git checkout release-0.1.2
RUN ./configure
RUN make
RUN make install

### Install Ryu controller
RUN apt-get install -y python-dev python-pip python-lxml
RUN apt-get install -y libxml2-dev
RUN apt-get install -y git
RUN pip install --upgrade six
WORKDIR /root
RUN git clone https://github.com/osrg/ryu.git
WORKDIR /root/ryu/tools
RUN pip install -r pip-requires
WORKDIR /root/ryu
RUN python ./setup.py install

### Install simpleRouter
WORKDIR /root
RUN git clone https://github.com/ttsubo/simpleRouter.git
