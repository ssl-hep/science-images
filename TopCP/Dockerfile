# syntax=docker/dockerfile:1

# This is the default AnalysisBase version
ARG ANALYSIS_BASE_VERSION=25.2.50
FROM gitlab-registry.cern.ch/atlas/athena/analysisbase:${ANALYSIS_BASE_VERSION}
ARG TOPCPTOOLKIT_TAG=v2.18.0_v0.2
ARG GITLAB_PROJECT="atlas-physics/beauty/common-tools"

SHELL [ "/bin/bash", "-c" ]

USER root

RUN if [[ $EL == 7 ]] ; then { \
        sed -i -e 's/linuxsoft.cern.ch\/internal/dl.fedoraproject.org\/pub/g' /etc/yum.repos.d/epel.repo ; \
        sed -i -e 's/linuxsoft.cern.ch\/epel/dl.fedoraproject.org\/pub\/archive\/epel/g' /etc/yum.repos.d/epel.repo ; \
    } ; else { \
        dnf install -y epel-release ; \
    } ; fi
RUN curl -s -o /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg https://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg \
    && if [[ $EL == 7 ]] ; then { \
      curl -s -o /etc/yum.repos.d/wlcg-centos7.repo http://linuxsoft.cern.ch/wlcg/wlcg-centos7.repo ; \
    } ; else { \
        curl -s -o /etc/yum.repos.d/wlcg-el${EL}.repo http://linuxsoft.cern.ch/wlcg/wlcg-el${EL}.repo ; \
    } ; fi
RUN if [[ $EL == 7 ]] ; then { \
        yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el${EL}-release-latest.rpm  ; \
    } ; else { \
        yum install -y https://repo.osg-htc.org/osg/24-main/osg-24-main-el9-release-latest.rpm ; \
    } ; fi \
    && yum -y update \
    && yum -y install nc jq \
    && yum install -y xrootd-client xrootd \
        xrootd-voms voms-clients wlcg-voms-atlas osg-ca-certs \
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