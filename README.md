# Run ansible in a container

Instead of installing `ansible` you might want to run it in ephemeral docker containers, using aliases:

```bash
alias ansible='docker run --rm -it -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible'
alias ansible-galaxy='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible-galaxy'
alias ansible-playbook='docker run --rm -it --workdir /etc/ansible -v $(pwd):/etc/ansible -v ~/.ssh/kickstart:/root/.ssh/id_rsa simplificator/ansible ansible-playbook'
```
