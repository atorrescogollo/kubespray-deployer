#!/bin/bash

set -e

[ ! -f "$CLUSTER_INVENTORY" ] \
    && echo >&2 "ERR: CLUSTER_INVENTORY='$CLUSTER_INVENTORY' was not found" \
    && exit 1

set -x
# Build kubespray inventory:
#   Adapt cluster_inventory.yml to kubespray_inventory.ini
ansible-playbook -i localhost, \
  playbooks/kubespray_inventory_builder.yml \
  -e "infile=${CLUSTER_INVENTORY}" \
  -e "outfile=${KUBESPRAY_INVENTORY}"

# Run kubespray cluster.yml
ansible-playbook -i "${KUBESPRAY_INVENTORY}" \
  ${KUBESPRAY_HOME}/cluster.yml
