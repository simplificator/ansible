# Simplificator Ansible
This image let's you run ansible commands in a container.

## Alpine vs. Debian10 Windows Deploy vs. the other images
Use the alpine-based image for your continous integration. It is the slimmest of all the images (~260 MB).

For deploys against a windows system, the windows-deploy tag is your choice. It contains the pywinrm libraries for the connection to WinRM.

The Debian- und Ubuntu-based Images contain additional dependencies like `libapt-pkg-dev` to test playbooks in the containers. Use them in a Dockerfile like this:

~~~~Dockerfile
FROM simplificator/ansible:debian10

ADD ./roles /etc/ansible/roles

ADD install-some-software.yml .

RUN ansible-playbook install-some-software.yml --connection=local --extra-vars "target_hosts=localhost"
~~~~

Now you could built this Docker file with docker build. If something is wrong with your role, the build will fail.

## Debian 8
We don't support Debian 8 anymore. However, if you need it, there is a tag available named [debian8-2-9](https://hub.docker.com/layers/simplificator/ansible/debian8-2-9/images/sha256-ab5b6bd593163e91e2500d4850e894b7016277c45c4669c0274a566b8f59d9bc?context=repo) which doesn't receive any updates.

## Run ansible in a container

Instead of installing `ansible` you might want to run it in ephemeral docker containers, using aliases:

```bash
alias ansible='docker run --rm -it -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible'
alias ansible-galaxy='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible-galaxy'
alias ansible-playbook='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh/kickstart:/root/.ssh/id_rsa simplificator/ansible ansible-playbook'
```
