# SOURCE: https://github.com/William-Yeh/docker-ansible/blob/master/alpine3-onbuild/Dockerfile
FROM python:3.8-alpine

RUN echo "===> Adding Ansible dependencies..."  && \
	apk --update add git bash  && \
    apk --update add --virtual build-dependencies libffi-dev openssl-dev build-base && \
    pip install --upgrade pip pycrypto cffi && \
    \
    echo "===> Installing Ansible..."  && \
    pip install ansible                && \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies libffi-dev openssl-dev build-base && \
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