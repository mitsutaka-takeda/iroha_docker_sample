FROM hyperledger/iroha-docker-develop:v1

MAINTAINER Mitsutaka Takeda
 
###########################
# Setup iroha
USER root

RUN mkdir -p /tmp/ccache
RUN mkdir -p /opt/iroha/bin
ADD ./irohad /opt/iroha/bin
ADD ./iroha-cli /opt/iroha/bin

WORKDIR /opt/iroha

###########################

