# syntax=docker/dockerfile:1

# This is the default AnalysisBase version
ARG ANALYSIS_BASE_VERSION="25.2.38" 
FROM gitlab-registry.cern.ch/atlas/athena/analysisbase:${ANALYSIS_BASE_VERSION} AS base

ARG TOPCPTOOLKIT_TAG="v2.15.1"
ARG TOPCPTOOLKIT_BRANCH="main"

SHELL [ "/bin/bash", "-c" ]

USER root

RUN yum update -y
RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el9-release-latest.rpm && yum install -y osg-ca-certs 
RUN yum install -y nc

# download TopCPToolkit repo
WORKDIR /
RUN --mount=type=secret,id=GIT_KEY,env=GIT_KEY\
    git clone https://${GIT_KEY}@gitlab.cern.ch/atlasphys-top/reco/TopCPToolkit.git
WORKDIR /TopCPToolkit
RUN    git checkout tags/${TOPCPTOOLKIT_TAG}

# Make /TopCPToolkit/generate directory where runTop_el.py is executed
RUN mkdir -p generate
ENV RUN_LOC="/TopCPToolkit/generate"

# Define config location where user defined YAML files will reside
ENV CONFIG_LOC="/TopCPToolkit/source/TopCPToolkit/share/configs/customConfig"
RUN mkdir -p $CONFIG_LOC

ENV X509_USER_PROXY=/tmp/x509_proxy

WORKDIR /TopCPToolkit/build

RUN source /release_setup.sh && \
    cmake ../source && \
    source */setup.sh && \
    make -j4

WORKDIR $RUN_LOC

COPY ./boot.bash_profile /root/.bashrc