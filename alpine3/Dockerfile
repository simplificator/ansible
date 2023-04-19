# SOURCE: https://github.com/William-Yeh/docker-ansible/blob/master/alpine3-onbuild/Dockerfile
FROM python:3.11-alpine

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG ANSIBLE_VERSION

RUN echo "===> Adding Ansible dependencies..."  && \
	apk --update add git bash openssh-client && \
    apk --update add --virtual build-dependencies libffi-dev openssl-dev build-base wget && \
    pip install --upgrade cryptography pip pycrypto cffi jmespath nodeping-api && \
    \
    echo "===> Installing Ansible..."  && \
    pip install ansible==$ANSIBLE_VERSION && \
    \
    echo "===> Installing Nodeping module ..."  && \
    mkdir -p ~/.ansible/plugins/modules/ && \
    wget -P ~/.ansible/plugins/modules https://raw.githubusercontent.com/NodePing/nodeping-ansible/ad1cefa077e6c7c18dc5bdaaa12e51e9584febb1/nodeping.py &&  \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies libffi-dev openssl-dev build-base wget && \
    rm -rf /var/cache/apk/*               && \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts

ONBUILD RUN  echo "===> Updating TLS certificates..."         && \
    apk --update add openssl ca-certificates

ONBUILD WORKDIR  /etc/ansible

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
