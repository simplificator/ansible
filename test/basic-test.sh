#!/bin/bash
set -e

printf "\nChecking Python version\n"
python -v 2> /dev/null || python3 -v 2> /dev/null || exit 1

printf "\nChecking that ansible toolbet is avaible\n"
ansible --version 2> /dev/null || exit 1
ansible-galaxy --version 2> /dev/null || exit 1
ansible-playbook --version 2> /dev/null || exit 1
ansible-vault --version 2> /dev/null || exit 1

printf "\nChecking that Ansible can decrypt a Vault\n"
if ansible-vault view --vault-password-file test/password test/vault.yml | grep -q 'test'; then
	echo "Matched"
else
	exit 1
fi

printf "\nChecking that Ansible can download collections and roles from Galaxy\n"
ansible-galaxy role install -r test/requirements.yml 2> /dev/null || exit 1
ansible-galaxy collection install -r test/requirements.yml -p ./ 2> /dev/null || exit 1
