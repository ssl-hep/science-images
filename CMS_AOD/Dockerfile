FROM cmsopendata/cmssw_5_3_32:latest

USER root

# Fix a repo key in the container
RUN sed -i 's/EUGridPMA-RPM-3/EUGridPMA-RPM-4/' /etc/yum.repos.d/EGI-trustanchors.repo
RUN yum clean all &&  yum -y update && yum -y install nc jq

ADD gai.conf /etc/gai.conf

# Install everything needed to host/run the analysis jobs
WORKDIR /servicex

# Turn this on so that stdout isn't buffered - otherwise logs in kubectl don't
# show up until much later!
ENV PYTHONUNBUFFERED=1
ENV INSTANCE="cms_aod_cpp_transformer"
ENV DESC="CMS AOD CPP Transformer"

WORKDIR /home/atlas
