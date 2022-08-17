#!/bin/bash

set -eu

BASE_DIR="$(cd $(dirname $0)/; pwd)"
PROJECT_BASE_DIR="$(cd $(dirname $0)/../; pwd)"

. "${PROJECT_BASE_DIR}/_sh_core/core_function.sh"

# install python3
update_repository
install_package python3 ansible

# install galaxy for version management system
ansible-galaxy install cimon-io.asdf -p ${BASE_DIR}/roles/external/
# install galaxy for docker
ansible-galaxy install geerlingguy.pip -p ${BASE_DIR}/roles/external/
ansible-galaxy install geerlingguy.docker -p ${BASE_DIR}/roles/external/