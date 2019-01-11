#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo -e "
Usage: config_generate.sh <host-type>

Generates config for this host type into /hab/user
"
  exit 1
fi


HOST_TYPE=$1

ansible-playbook -i "127.0.0.1," --extra-vars "env=local connection=local" "${HOST_TYPE}-config.yml"
