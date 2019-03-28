FROM nvidia/cuda:10.1-devel-ubuntu18.04
LABEL version "0.1"
LABEL description "Anaconda3 inside a CUDA docker."

ENV ANACONDA_VERSION Anaconda3-2018.12

ENV ANACONDA_INSTALLER ${ANACONDA_VERSION}-Linux-x86_64.sh
ENV ANACONDA_MD5_HASH  c9af603d89656bc89680889ef1f92623

ENV APT_PACKAGES wget curl apt-transport-https ca-certificates

WORKDIR /tmp

RUN apt-get update && \
    apt-get install --yes ${APT_PACKAGES} && \
    echo "${ANACONDA_MD5_HASH} ${ANACONDA_INSTALLER}" > /tmp/${ANACONDA_INSTALLER}.md5 && \
    wget -q https://repo.anaconda.com/archive/${ANACONDA_INSTALLER} && \
    md5sum -c ${ANACONDA_INSTALLER}.md5 && \
    chmod +x ${ANACONDA_INSTALLER} && \
    ./${ANACONDA_INSTALLER} -b -p /opt/anaconda3

ENV PATH="/opt/anaconda3/bin:${PATH}"

WORKDIR /root
