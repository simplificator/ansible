# Simplificator Ansible
This image let's you run ansible commands in a container.

## Deprecated

As per 28th of December, 2023, this project is no longer maintained. The repository is already archived. The Docker images will be online until the end of 2024. Please consider the following alternatives.

### If you want to just run Ansible in Docker

We recommend using the [Docker image by willhallonline](https://hub.docker.com/r/willhallonline/ansible). It seems to be the most maintained version at the moment.

### If you want to run Ansible

For our internal infrastructure projects, we use a plain VM from our CI provider and their default Python 3 version. Ansible is installed using a `Pipfile` and updated in regular intervals using [Renovate](https://www.mend.io/renovate/). We tried using a Docker-based image again, however, our CI providers has certain constraints what kind of software needs to be present in an image. So in order to avoid trouble, we went this route, which might be an option for you as well.

### If you want to test your Ansible roles

Our main motivation for all those images was to test Ansible roles (see an example below). Consider using [Molecule](https://ansible.readthedocs.io/projects/molecule/) for this task. We make heavily use of Molecule in our open-source Ansible roles. Feel free to copy the setup from there, e.g. from [ansible-role-linux-accounts](https://github.com/simplificator/ansible-role-linux-accounts).

## Alpine vs. Debian 11 Windows Deploy vs. the other images
Use the alpine-based image for your continous integration. It is the slimmest of all the images (~260 MB).

For deploys against a windows system, the windows-deploy tag is your choice. It contains the pywinrm libraries for the connection to WinRM.

The Debian- und Ubuntu-based Images contain additional dependencies like `libapt-pkg-dev` to test playbooks in the containers. Use them in a Dockerfile like this:

~~~~Dockerfile
FROM simplificator/ansible:debian11

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
