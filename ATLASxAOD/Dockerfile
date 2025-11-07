ARG ANALYSISBASE_TAG=25.2.38

FROM atlas/analysisbase:$ANALYSISBASE_TAG
FROM gitlab-registry.cern.ch/atlas/athena/analysisbase:$ANALYSISBASE_TAG
ARG EL=9

USER root

RUN if [[ $EL == 7 ]] ; then { \
        sed -i -e 's/linuxsoft.cern.ch\/internal/dl.fedoraproject.org\/pub/g' /etc/yum.repos.d/epel.repo ; \
        sed -i -e 's/linuxsoft.cern.ch\/epel/dl.fedoraproject.org\/pub\/archive\/epel/g' /etc/yum.repos.d/epel.repo ; \
    } ; else { \
        dnf install -y epel-release; \
    } ; fi
RUN curl -s -o /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg https://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg \
    && if [[ $EL == 7 ]] ; then { \
      curl -s -o /etc/yum.repos.d/wlcg-centos7.repo http://linuxsoft.cern.ch/wlcg/wlcg-centos7.repo ; \
    } ; else { \
        curl -s -o /etc/yum.repos.d/wlcg-el${EL}.repo http://linuxsoft.cern.ch/wlcg/wlcg-el${EL}.repo ; \
    } ; fi
RUN if [[ $EL == 7 ]] ; then { \
        yum install -y https://repo.osg-htc.org/osg/3.6/osg-3.6-el${EL}-release-latest.rpm && \
        sed -i 's|^mirrorlist=.*|#mirrorlist=|' /etc/yum.repos.d/osg.repo && \
        sed -i 's|^#baseurl=http|baseurl=http|' /etc/yum.repos.d/osg.repo ; \
    } ; else { \
        yum install -y https://repo.osg-htc.org/osg/25-main/osg-25-main-el9-release-latest.rpm ; \
    } ; fi \
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
ENV X509_CERT_DIR=/etc/grid-security/certificates

WORKDIR /home/atlas
