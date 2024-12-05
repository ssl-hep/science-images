ARG BASE_IMAGE=gitlab-registry.cern.ch/atlas/athena/analysisbase:25.2.14
FROM ${BASE_IMAGE} as base

SHELL [ "/bin/bash", "-c" ]

USER root

RUN yum update -y
RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el9-release-latest.rpm && yum install -y osg-ca-certs 

COPY ./TopCPToolkit /TopCPToolkit
WORKDIR /TopCPToolkit

RUN mkdir -p generate
ENV RUN_LOC "/TopCPToolkit/generate"
WORKDIR $RUN_LOC
RUN mkdir -p data

ENV CONFIG_LOC "/TopCPToolkit/source/TopCPToolkit/share/configs/customConfig"
RUN mkdir -p $CONFIG_LOC

ENV X509_USER_PROXY=/tmp/x509_proxy

RUN chmod +x /TopCPToolkit/build/x86_64-el9-gcc13-opt/setup.sh

COPY ./boot.sh /
ENTRYPOINT ["/boot.bash_profile"]