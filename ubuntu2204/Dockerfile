# SOURCE: https://github.com/William-Yeh/docker-ansible/blob/master/ubuntu18.04-onbuild/Dockerfile
FROM ubuntu:22.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG ANSIBLE_VERSION

RUN echo "===> Installing dev libraries and supporting tools ..."  && \
    apt-get update -y  &&  apt-get install --fix-missing          && \
    DEBIAN_FRONTEND=noninteractive         \
    apt-get install -y python3 python3-pip python3-dev \
    curl gcc git libffi-dev libssl-dev libapt-pkg-dev git openssh-client gnupg wget procps && \
    pip3 install --upgrade pycrypto cffi jmespath nodeping-api && \
    \
    echo "===> Installing Ansible..."   && \
    pip3 install ansible==$ANSIBLE_VERSION && \
    \
    echo "===> Installing Nodeping module ..."  && \
    mkdir -p ~/.ansible/plugins/modules/ && \
    wget -P ~/.ansible/plugins/modules https://raw.githubusercontent.com/NodePing/nodeping-ansible/ad1cefa077e6c7c18dc5bdaaa12e51e9584febb1/nodeping.py &&  \
    \
    echo "===> Removing unused APT resources..."                  && \
    apt-get -f -y --auto-remove remove \
    gcc libffi-dev libssl-dev python3-dev wget && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           && \
    \
    echo "===> Adding hosts for convenience..."        && \
    mkdir -p /etc/ansible                              && \
    echo 'localhost' > /etc/ansible/hosts

ONBUILD  RUN DEBIAN_FRONTEND=noninteractive  apt-get update   && \
    echo "===> Updating TLS certificates..."         && \
    apt-get install -y openssl ca-certificates

ONBUILD  WORKDIR /etc/ansible

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
