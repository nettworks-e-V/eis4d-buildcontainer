FROM debian:buster
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_GROUP=developer
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer
ARG UID=1000
ARG GID=1000

# Define environment vars
ENV WORK_DIR=/data/work \
    REPO_DIR=/var/www/html/repo \
    TARGET_DIR=/var/www/html/repo/source

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR} ${TARGET_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y \
    apt-utils \
    autoconf \
    automake \
    autotools-dev \
    bash \
    build-essential \
    cmake \
    dh-make \
    debhelper \
    devscripts \
    fakeroot \
    file \
    flex \
    gfortran \
    git \
    gnupg \
    libncurses5-dev \
    lintian \
    mc \
    openssh-client \
    patch \
    patchutils \
    pbuilder \
    perl \
    python \
    quilt \
    rsync \
    sudo \
    xutils-dev \
 && apt-get clean \
 && groupadd --gid ${GID} ${DEVELOP_GROUP} \
 && useradd --create-home --home-dir /home/${DEVELOP_USER} --shell /bin/bash --uid ${UID} --gid ${GID} ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && chown ${DEVELOP_USER}:${DEVELOP_GROUP} /home/${DEVELOP_USER} -R \
 && ulimit -v unlimited

COPY createPackageRepository.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/createPackageRepository.sh

#USER ${DEVELOP_USER}
