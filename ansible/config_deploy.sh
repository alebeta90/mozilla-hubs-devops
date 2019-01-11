#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo -e "
Usage: config_deploy.sh <host-type> [environment]

Performs a config deploy to the Habitat cluster to update configurations for the specified host type.
"
  exit 1
fi

# TODO this should get a lot smarter -- if you are on a branch, disallow. If you have working changes, warn the user and require a flag.
git pull origin master

HOST_TYPE=$1
ENVIRONMENT=$2

[[ -z "$ENVIRONMENT" ]] && ENVIRONMENT=dev


ansible-playbook --ask-vault-pass -i "${TARGET_IP}," --ssh-common-args="-i ~/.ssh/mozilla_mr_id_rsa -o ProxyCommand=\"ssh -W %h:%p -o StrictHostKeyChecking=no -i ~/.ssh/mozilla_mr_id_rsa ubuntu@${BASTION_IP}\"" --extra-vars "env=${ENVIRONMENT} connection=ssh" -u ubuntu "${HOST_TYPE}-config.yml"
