# docker run --name server1 -d -P  ansible-docker
FROM ubuntu:18.04

ARG DEF_USER="alextu"
# Update the index of available packages.
RUN apt-get update

# Install the requires package.
RUN apt-get install -y openssh-server python sudo curl wget bash-completion openssl \
      && \
      apt-get clean

# Setting the sshd.
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Create a new user.
#
# - username: alextu
# - password: alextu
RUN useradd --create-home --shell /bin/bash \
      --password $(openssl passwd -1 alextu) alextu

# Add sudo permission.
RUN echo 'alextu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY authorized_keys /tmp
# Setting ssh public key.
RUN mkdir /home/$DEF_USER/.ssh && \
      mv /tmp/authorized_keys /home/$DEF_USER/.ssh/ && \
      chown -R $DEF_USER:$DEF_USER /home/$DEF_USER/.ssh/ && \
      chmod 644 /home/$DEF_USER/.ssh/authorized_keys && \
      chmod 700 /home/$DEF_USER/.ssh

EXPOSE 22

# Run ssh server daemon.
CMD ["/usr/sbin/sshd", "-D"]

