# based on https://github.com/dask/dask-docker/blob/master/base/Dockerfile
# but more permissive about image size due to read-only requirement in openshift
# FROM daskdev/dask:2.9.0
ARG ROOTVER=6.32.04
ARG PLATFORM=ubuntu24.04
FROM rootproject/root:${ROOTVER}-${PLATFORM}
ARG CERTIFICATE_VERSION=1.134IGTFNEW

RUN apt update -y && apt upgrade -y && \
    apt-get install gnupg2 netcat-traditional jq sudo xrootd-client -y

RUN apt update && \
    apt upgrade -y && \
    apt install -y sudo

RUN mkdir -p /etc/grid-security/
RUN export X509_CERT_DIR=/etc/grid-security/certificates/
RUN wget https://repo.opensciencegrid.org/cadist/${CERTIFICATE_VERSION}/osg-certificates-${CERTIFICATE_VERSION}.tar.gz
RUN tar -xvf osg-certificates-${CERTIFICATE_VERSION}.tar.gz -C /etc/grid-security/

RUN useradd -ms /bin/bash output -G sudo && passwd -d output
RUN mkdir -p /etc/grid-security/certificates /etc/grid-security/vomsdir

WORKDIR /servicex
COPY proxy-exporter.sh .
RUN chmod +x proxy-exporter.sh

ENV PYTHONUNBUFFERED=1
ENV X509_USER_PROXY=/tmp/grid-security/x509up

RUN chgrp -R 0 /home/output && chmod -R g+rwX /home/output
