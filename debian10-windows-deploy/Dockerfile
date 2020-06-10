
# SOURCE: https://github.com/William-Yeh/docker-ansible/blob/master/ubuntu18.04-onbuild/Dockerfile
FROM debian:buster

RUN echo "===> Installing dev libraries and supporting tools ..."  && \
    apt-get update -y  &&  apt-get install --fix-missing          && \
    DEBIAN_FRONTEND=noninteractive         \
    apt-get install -y python3 python3-pip python3-dev \
    gcc git libffi-dev libssl-dev ssh && \
    pip3 install --upgrade pycrypto cffi jmespath && \
    \
    echo "===> Installing Ansible & PyWinRM..."   && \
    pip3 install ansible=='2.9.3' && \
    pip3 install pywinrm[credssp]=='0.4.1' && \
    \
    echo "===> Removing unused APT resources..."                  && \
    apt-get -f -y --auto-remove remove \
    gcc libffi-dev libssl-dev python3-dev && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           && \
    \
    echo "===> Adding hosts for convenience..."        && \
    mkdir -p /etc/ansible                              && \
    echo 'localhost' > /etc/ansible/hosts

ONBUILD RUN DEBIAN_FRONTEND=noninteractive  apt-get update   && \
    echo "===> Updating TLS certificates..."         && \
    apt-get install -y openssl ca-certificates

ONBUILD WORKDIR  /etc/ansible

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
