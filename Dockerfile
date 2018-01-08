FROM alpine:3.6
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer

# Define environment vars
ENV WORK_DIR=/data/work

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

RUN apk update \
 && apk upgrade \
 && apk add \
    alpine-sdk \
    bash \
    openssh \
    mc \
    sudo \
    rsync \
    autoconf \
    automake \
    libtool \
    flex \
    coreutils \
    ncurses-dev \
    linux-headers \
    openrc \
 && adduser -D -h /home/${DEVELOP_USER} -s /bin/bash -G abuild ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && echo "${DEVELOP_USER}   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/cache/distfiles \
 && chmod a+w /var/cache/distfiles

# Mount point for develop user home
VOLUME /home/${DEVELOP_USER}

# Mount point for global abuild configuration
RUN mv /etc/abuild.conf /etc/abuild.conf.default
#COPY etc/abuild.conf.default /etc/abuild.conf.default
#VOLUME /etc/abuild.conf

#USER ${DEVELOP_USER}

#RUN git config --global user.name "Your Full Name" \
# && git config --global user.email "your@email.address"
