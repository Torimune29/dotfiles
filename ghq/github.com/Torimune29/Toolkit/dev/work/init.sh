#!/bin/bash

set -eu

_project_root_dir="$(cd $(dirname $0)/../../; pwd)"
. $_project_root_dir/_bootstrap/function.sh

# svn
install_package subversion

