FROM debian:9

RUN apt-get update && apt-get install -y python-pip git
RUN pip install ansible

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
