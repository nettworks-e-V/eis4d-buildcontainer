FROM alpine:3.6
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer
ARG UID="1000"

# Define environment vars
ENV WORK_DIR=/data/work

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

RUN apk update \
 && apk upgrade \
 && apk add alpine-sdk bash openssh \
 && adduser -D -h /home/${DEVELOP_USER} -u ${UID} -s /bin/bash ${DEVELOP_USER} \
 && chown ${DEVELOP_USER}:${DEVELOP_USER} /home/${DEVELOP_USER} -R \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && echo "${DEVELOP_USER}   ALL=(ALL) ALL" >> /etc/sudoers \
 && addgroup ${DEVELOP_USER} abuild \
 && mkdir -p /var/cache/distfiles \
 && chmod a+w /var/cache/distfiles

#USER ${DEVELOP_USER}

#RUN git config --global user.name "Your Full Name" \
# && git config --global user.email "your@email.address"
