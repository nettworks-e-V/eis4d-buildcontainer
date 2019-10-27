FROM debian:buster-slim
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_GROUP=developer
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer
ARG UID="1000"
ARG GID="1000"

# Define environment vars
ENV WORK_DIR=/data/work

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y \
    bash \
    build-essential \
    openssh-client \
    mc \
    sudo \
    rsync \
    cmake \
 && apt-get clean \
 && groupadd --gid ${GID} ${DEVELOP_GROUP} \
 && useradd --create-home --home-dir /home/${DEVELOP_USER} --shell /bin/bash --uid ${UID} --gid ${GID} ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && chown ${DEVELOP_USER}:${DEVELOP_GROUP} /home/${DEVELOP_USER} -R \
 && ulimit -v unlimited

# Mount point for develop user home
VOLUME /home/${DEVELOP_USER}

#USER ${DEVELOP_USER}
