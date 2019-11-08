FROM catapultcx/centos:centos8

LABEL maintainer="info@catapult.cx"
LABEL org.label-schema.description="Base node v12 image"

ARG NODE_VERSION=12.13.0
ARG NODE_DISTRO=linux-x64
ARG DEFAULT_USER=${DEFAULT_USER}
USER root

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 && \
    curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz -o node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz && \
    curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc -o SHASUMS256.txt.asc && \
    gpg --verify SHASUMS256.txt.asc && \
    grep node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz SHASUMS256.txt.asc | sha256sum -c - && \
    mkdir -p /usr/local/lib/nodejs && \
    tar -xzf "node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz" -C /usr/local/lib/nodejs && \
    echo "export PATH=/usr/local/lib/nodejs/node-v${NODE_VERSION}-${NODE_DISTRO}/bin:$PATH" >> /etc/bashrc && \
    rm node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz SHASUMS256.txt.asc

USER $DEFAULT_USER


