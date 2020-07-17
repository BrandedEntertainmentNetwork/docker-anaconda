FROM nvidia/cuda:10.2-devel-ubuntu18.04
LABEL version "a2019.10-c10.2"
LABEL description "Anaconda3 inside a CUDA docker."

ENV DEBIAN_FRONTEND noninteractive

ENV ANACONDA_VERSION Anaconda3-2019.10

ENV ANACONDA_INSTALLER ${ANACONDA_VERSION}-Linux-x86_64.sh
ENV ANACONDA_MD5_HASH b77a71c3712b45c8f33c7b2ecade366c

ENV APT_PACKAGES wget curl apt-transport-https ca-certificates

WORKDIR /tmp

RUN apt-get update && \
    apt-get install --yes ${APT_PACKAGES} && \
    echo "${ANACONDA_MD5_HASH} ${ANACONDA_INSTALLER}" > /tmp/${ANACONDA_INSTALLER}.md5 && \
    wget -q https://repo.anaconda.com/archive/${ANACONDA_INSTALLER} && \
    md5sum -c ${ANACONDA_INSTALLER}.md5 && \
    chmod +x ${ANACONDA_INSTALLER} && \
    ./${ANACONDA_INSTALLER} -b -p /opt/anaconda3 && \
    ln -s /opt/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/anaconda3/etc/profile.d/conda.sh" >> /root/.bashrc && \
    echo "conda activate" >> /root/.bashrc && \
    rm -fr /tmp/${ANACONDA_INSTALLER} /tmp/${ANACONDA_INSTALLER}.md5

WORKDIR /root
