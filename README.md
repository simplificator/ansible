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

## Run ansible in a container

Instead of installing `ansible` you might want to run it in ephemeral docker containers, using aliases:

```bash
alias ansible='docker run --rm -it -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible'
alias ansible-galaxy='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible-galaxy'
alias ansible-playbook='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh/kickstart:/root/.ssh/id_rsa simplificator/ansible ansible-playbook'
```
