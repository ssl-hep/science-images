# syntax=docker/dockerfile:1

# This is the default AnalysisBase version
ARG ANALYSIS_BASE_VERSION=25.2.50
FROM gitlab-registry.cern.ch/atlas/athena/analysisbase:${ANALYSIS_BASE_VERSION}
ARG TOPCPTOOLKIT_TAG=v2.18.0_v0.2
ARG GITLAB_PROJECT="atlas-physics/beauty/common-tools"

SHELL [ "/bin/bash", "-c" ]

USER root

# Install OSG repo and xrootd client
RUN yum install -y https://repo.osg-htc.org/osg/25-main/osg-25-main-el9-release-latest.rpm \
    && yum -y update \
    && yum -y install nc \
    && yum install -y osg-ca-certs \
    && yum clean all

# download TopCPToolkit repo
WORKDIR /
RUN --mount=type=secret,id=GIT_KEY,env=GIT_KEY\
    git clone https://${GIT_KEY}@gitlab.cern.ch/${GITLAB_PROJECT}/TopCPToolkit.git
WORKDIR /TopCPToolkit
RUN   git fetch -a && git checkout ${TOPCPTOOLKIT_TAG}

# Make /TopCPToolkit/run directory where runTop_el.py is executed
RUN mkdir -p run
ENV RUN_LOC=/TopCPToolkit/run

# Define config location where user defined YAML files will reside
ENV CONFIG_LOC="/TopCPToolkit/source/TopCPToolkit/share/configs/customConfig"
RUN mkdir -p $CONFIG_LOC

ENV X509_USER_PROXY=/tmp/grid-security/x509up

WORKDIR /TopCPToolkit/build

RUN source /release_setup.sh && \
    cmake ../source && \
    source */setup.sh && \
    make -j4

WORKDIR $RUN_LOC

COPY ./boot.bash_profile /root/.bashrc