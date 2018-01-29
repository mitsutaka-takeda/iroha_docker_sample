FROM hyperledger/iroha-docker-develop:v1

MAINTAINER Daisuke Shiamda

###########################
# Setup iroha
USER root

RUN mkdir -p /tmp/ccache
RUN mkdir -p /opt/iroha/bin
ADD ./startup.sh /opt/iroha/bin
RUN chmod +x /opt/iroha/bin/startup.sh
ADD ./bin/irohad /opt/iroha/bin
ADD ./bin/iroha-cli /opt/iroha/bin

RUN mkdir -p /opt/iroha/template
ADD ./config.sample /opt/iroha/template

WORKDIR /opt/iroha
CMD [./bin/startup.sh]
###########################

