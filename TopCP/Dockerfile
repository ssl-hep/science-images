# use AnalysisBase:25.2.14 as base image. Will be dynamic in the future
ARG BASE_IMAGE=gitlab-registry.cern.ch/atlas/athena/analysisbase:25.2.14
FROM ${BASE_IMAGE} AS base

SHELL [ "/bin/bash", "-c" ]

RUN yum update -y
RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el9-release-latest.rpm && yum install -y osg-ca-certs 
RUN yum install -y nc

# Import TopCPToolkit from local filesystem
COPY ./TopCPToolkit /TopCPToolkit
WORKDIR /TopCPToolkit

# Make /TopCPToolkit/generate directory where runTop_el.py is executed
RUN mkdir -p generate
ENV RUN_LOC "/TopCPToolkit/generate"
WORKDIR $RUN_LOC

# Define config location where user defined YAML files will reside
ENV CONFIG_LOC "/TopCPToolkit/source/TopCPToolkit/share/configs/customConfig"
RUN mkdir -p $CONFIG_LOC

ENV X509_USER_PROXY=/tmp/x509_proxy

RUN chmod +x /TopCPToolkit/build/x86_64-el9-gcc13-opt/setup.sh

USER servicex

COPY ./boot.bash_profile /