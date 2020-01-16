#!/bin/bash
set -e

echo '\nCheck that the GPG command is available\n'
gpg --version 2> /dev/null || exit 1

echo '\nInstall a sample playbook against localhost\n'
ansible-playbook test/test-playbook.yml --connection=local 2> /dev/null || exit 1
