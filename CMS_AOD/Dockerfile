FROM cmsopendata/cmssw_5_3_32:latest

USER root

RUN yum clean all
RUN yum -y update
RUN yum -y install nc

# Install everything needed to host/run the analysis jobs
WORKDIR /servicex

# Turn this on so that stdout isn't buffered - otherwise logs in kubectl don't
# show up until much later!
ENV PYTHONUNBUFFERED=1
ENV INSTANCE="cms_aod_cpp_transformer"
ENV DESC="CMS AOD CPP Transformer"

WORKDIR /home/atlas
