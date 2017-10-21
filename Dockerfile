FROM alpine:3.6
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG GIT_ACCOUNT=anonymous
ARG GIT_PASS=''

# Define environment vars
ENV GIT_ACCOUNT=${SVN_ACCOUNT} \
    GIT_PASS=${SVN_PASS} \
    GIT_CLONE_DIR=/opt/git_clone

# Mount point for Edomi backups
VOLUME ${GIT_CLONE_DIR}
