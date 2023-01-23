FROM alpine:latest

RUN set -x \
  && apk --update add \
    ansible \
    openssh-client \
    rsync \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /ansible

COPY --chown=root --chmod=644 ssh_config /etc/ssh/ssh_config
COPY tasks /ansible/tasks
COPY ansible.cfg deploy.yml /ansible/

RUN  /usr/bin/ansible-galaxy install ansistrano.deploy ansistrano.rollback
