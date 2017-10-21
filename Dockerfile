FROM alpine:3.6
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG GIT_ACCOUNT=anonymous
ARG GIT_PASS=''
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer

# Define environment vars
ENV GIT_ACCOUNT=${GIT_ACCOUNT} \
    GIT_PASS=${GIT_PASS} \
    GIT_CLONE_DIR=/opt/git_clone

# Mount point for Edomi backups
VOLUME ${GIT_CLONE_DIR}

RUN apk update \
 && apk upgrade \
 && apk add alpine-sdk \
 && adduser -D ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_PASS}" | chpasswd \
 && echo "${DEVELOP_USER}   ALL=(ALL) ALL" >> /etc/sudoers

USER ${DEVELOP_USER}

#RUN git config --global user.name "Your Full Name" \
# && git config --global user.email "your@email.address"
