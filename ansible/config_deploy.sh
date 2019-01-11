#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo -e "
Usage: config_deploy.sh <host-type> [environment] HOST_IP

Performs a config deploy to the Habitat cluster to update configurations for the specified host type.
"
  exit 1
fi

HOST_TYPE=$1
ENVIRONMENT=$2
TARGET_IP=$3

[[ -z "$ENVIRONMENT" ]] && ENVIRONMENT=dev


ansible-playbook -v -i "${TARGET_IP}," --ssh-common-args="-o ProxyCommand=\"ssh -W %h:%p -o StrictHostKeyChecking=no ubuntu@${TARGET_IP}\"" --extra-vars "env=${ENVIRONMENT}  target_ip=${TARGET_IP} connection=ssh" -u ubuntu "${HOST_TYPE}-config.yml"
