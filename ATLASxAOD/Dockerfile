ARG ANALYSISBASE_TAG=25.2.38

FROM atlas/analysisbase:$ANALYSISBASE_TAG
FROM gitlab-registry.cern.ch/atlas/athena/analysisbase:$ANALYSISBASE_TAG
USER root

RUN sed -i -e 's/linuxsoft.cern.ch/archives.fedoraproject.org\/pub\/archive/g' /etc/yum.repos.d/epel.repo
RUN curl -s -o /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg https://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg \
    && curl -s -o /etc/yum.repos.d/wlcg-el9.repo http://linuxsoft.cern.ch/wlcg/wlcg-el9.repo
RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el9-release-latest.rpm \
    && yum -y update \
    && yum -y install nc jq \
    && yum install -y xrootd-client xrootd \
        xrootd-voms voms-clients wlcg-voms-atlas osg-ca-certs \
    && yum clean all

# Install everything needed to host/run the analysis jobs
RUN mkdir -p /etc/grid-security/certificates /etc/grid-security/vomsdir
WORKDIR /servicex
COPY bashrc /servicex/.bashrc
COPY bashrc /servicex/.bash_profile
ADD gai.conf /etc/gai.conf

# Turn this on so that stdout isn't buffered - otherwise logs in kubectl don't
# show up until much later!
ENV PYTHONUNBUFFERED=1
ENV INSTANCE="atlas_xaod_cpp_transformer"
ENV DESC="ATLAS xAOD CPP Transformer"

ENV X509_USER_PROXY=/tmp/grid-security/x509up
ENV X509_CERT_DIR /etc/grid-security/certificates

WORKDIR /home/atlas
