#!/bin/bash

set -e

[ ! -f "$CLUSTER_INVENTORY" ] \
    && echo >&2 "ERR: CLUSTER_INVENTORY='$CLUSTER_INVENTORY' was not found" \
    && exit 1

# Build kubespray inventory:
#   Adapt cluster_inventory.yml to kubespray_inventory.ini
ansible-playbook -i localhost, \
  "$DEPLOYER_HOME/playbooks/kubespray_inventory_builder.yml" \
  -e "infile=${CLUSTER_INVENTORY}" \
  -e "outfile=${KUBESPRAY_INVENTORY}"

# Allow modules from kubespray
export ANSIBLE_LIBRARY="${ANSIBLE_LIBRARY}:${DEPLOYER_HOME}/library:${KUBESPRAY_HOME}/library"

# Deploy cluster ( kubespray cluster.yml )
ansible-playbook -i "${KUBESPRAY_INVENTORY}" \
  "$DEPLOYER_HOME/playbooks/deploy_cluster.yml"
