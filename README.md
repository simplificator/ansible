# ansible in a container

Instead of installing `ansible` you might want to run it in a container, using 

```
alias ansible='docker run --rm -it -v $(pwd):/etc/ansible -v ~/.ssh:/root/.ssh simplificator/ansible ansible'
```
