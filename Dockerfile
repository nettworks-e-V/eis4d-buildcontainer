FROM alpine:3.6
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer

# Define environment vars
ENV WORK_DIR=/data/work

# Mount point for Edomi backups
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

RUN apk update \
 && apk upgrade \
 && apk add alpine-sdk \
 && adduser -D ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && echo "${DEVELOP_USER}   ALL=(ALL) ALL" >> /etc/sudoers \
 && addgroup ${DEVELOP_USER} abuild \
 && mkdir -p /var/cache/distfiles \
 && chmod a+w /var/cache/distfiles

#USER ${DEVELOP_USER}

#RUN git config --global user.name "Your Full Name" \
# && git config --global user.email "your@email.address"
