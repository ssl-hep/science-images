ARG ROOTVER=6.36.04
ARG UPROOTVER=5.6.7
ARG PLATFORM=9-base
FROM almalinux/$PLATFORM

RUN dnf install -y epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf update -y && \
    dnf install -y https://repo.opensciencegrid.org/osg/25-main/osg-25-main-el9-release-latest.rpm && \
    dnf upgrade -y
RUN dnf install -y nc osg-ca-certs sudo

RUN useradd -ms /bin/bash output -G wheel && passwd -d output
RUN mkdir -p /etc/grid-security/certificates /etc/grid-security/vomsdir

RUN curl -fsSL https://pixi.sh/install.sh | sh
COPY pixi.lock pixi.toml ./
ARG ROOTVER UPROOTVER
RUN . ~/.bashrc && pixi install
RUN . ~/.bashrc && pixi add root==${ROOTVER} && \
    pixi add --pypi uproot[xrootd,http,s3]==${UPROOTVER} && \
    rm -rf ~/.cache/rattler
RUN . ~/.bashrc && pixi run python -m pip_audit

WORKDIR /servicex
COPY proxy-exporter.sh .
RUN chmod +x proxy-exporter.sh

ENV PYTHONUNBUFFERED=1

ENV X509_CERT_DIR=/etc/grid-security/certificates/
ENV X509_USER_PROXY=/tmp/grid-security/x509up

RUN chgrp -R 0 /home/output && chmod -R g+rwX /home/output
ENTRYPOINT ["/root/.pixi/bin/pixi", "shell"]
