#IMAGE_NAME: alextucc/ansible_manager:xenial
FROM alextucc/xenial_env:base
MAINTAINER Alex Tu
RUN \
# useradd -ms /bin/bash user; \
 apt-get update; \
 apt-get install -y ansible sshpass

#USER user
#WORKDIR /home/user
