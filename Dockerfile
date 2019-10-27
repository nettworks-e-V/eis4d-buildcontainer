FROM debian:buster-slim
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer

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
 && adduser -D -h /home/${DEVELOP_USER} -s /bin/bash ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && echo "${DEVELOP_USER}   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Mount point for develop user home
VOLUME /home/${DEVELOP_USER}

#USER ${DEVELOP_USER}
