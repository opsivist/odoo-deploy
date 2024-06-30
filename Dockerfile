FROM alpine:latest

RUN set -x \
  && apk add --no-cache \
    ansible \
    openssh-client \
    rsync

COPY --chown=root --chmod=644 ansible.cfg /etc/ansible/ansible.cfg

WORKDIR /ansible

COPY --chown=root --chmod=644 ssh_config /root/.ssh/config
COPY --chown=root tasks /ansible/tasks
COPY --chown=root deploy.yml /ansible

RUN  /usr/bin/ansible-galaxy install -p /ansible/roles ansistrano.deploy ansistrano.rollback
