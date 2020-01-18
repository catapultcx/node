FROM catapultcx/centos:centos8

LABEL maintainer="info@catapult.cx"
LABEL org.label-schema.description="Base nodejs v12 image"

ARG NODE_VERSION=12.14.1
ARG NODE_DISTRO=linux-x64
ARG USER=app
ARG GROUP=app
ARG UID=1000
ARG GID=1000
ARG APP_HOME=/home/app

RUN groupadd -g ${GID} ${GROUP} && \
    useradd -u ${UID} -g ${GID} -m -d ${APP_HOME} -s /bin/bash ${USER} && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys 4ED778F539E3634C779C87C6D7062848A1AB005C && \
    curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz -o node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz  && \
    curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc -o SHASUMS256.txt.asc  && \
    gpg --verify SHASUMS256.txt.asc  && \
    grep node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz SHASUMS256.txt.asc | sha256sum -c - && \
    mkdir -p /usr/local/lib/nodejs && \
    tar -xzf "node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz" -C /usr/local/lib/nodejs && \
    ln -s /usr/local/lib/nodejs/node-v${NODE_VERSION}-${NODE_DISTRO}/bin/node /usr/bin/node && \
    ln -s /usr/local/lib/nodejs/node-v${NODE_VERSION}-${NODE_DISTRO}/bin/npm /usr/bin/npm && \
    ln -s /usr/local/lib/nodejs/node-v${NODE_VERSION}-${NODE_DISTRO}/bin/npx /usr/bin/npx && \
    npm install -g gulp && \
    ln -s /usr/local/lib/nodejs/node-v${NODE_VERSION}-${NODE_DISTRO}/bin/gulp /usr/bin/gulp && \
    rm node-v${NODE_VERSION}-${NODE_DISTRO}.tar.gz SHASUMS256.txt.asc

ENV DEFAULT_USER=${USER}
USER ${USER}
WORKDIR ${APP_HOME}

