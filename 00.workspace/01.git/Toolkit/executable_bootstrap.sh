#!/bin/sh

set -eu

BASE_DIR="$(cd $(dirname $0)/; pwd)"
SH_CORE_FUNCTION_PATH="_sh_core/function.sh"
REPO_RAW_URL="https://raw.githubusercontent.com/Torimune29/Toolkit/main"
REPO_SH_CORE_FUNCTION_URL="${REPO_RAW_URL}/${SH_CORE_FUNCTION_PATH}"

# find sh/core.sh
if [ -e "${BASE_DIR}/${SH_CORE_FUNCTION_PATH}" ]; then
  # shellcheck source=_sh_core/function.sh
  . "${BASE_DIR}/${SH_CORE_FUNCTION_PATH}"  # use local
else  # fetch remote sh/core.sh
  _cwd="$(pwd)"
  _workdir="$(mktemp -d)"

  # fetch method
  _fetch=""
  if [ -x "$(command -v curl)" ];  then _fetch="curl --silent --retry 3 -O";
  elif [ -x "$(command -v wget)" ];    then _fetch="wget --quiet --tries=3";
  else echo "Error: fetch method not found." >&2; exit 1;
  fi

  # set teardown
  # shellcheck disable=SC2064
  trap "rm -rf ${_workdir}; cd ${_cwd}" INT PIPE TERM EXIT

  # fetch core script
  cd "${_workdir}" || exit 1
  eval $_fetch $REPO_SH_CORE_FUNCTION_URL
  cd "${_cwd}" || exit 1
  # shellcheck source=/dev/null
  . "${_workdir}/$(basename $REPO_SH_CORE_FUNCTION_URL)"
  unset _fetch _toolkit_core_function_url _toolkit_url
fi

# ready to get toolkit
update_repository
install_package bash git curl tar gzip

# call each bootstrap
args=$(capture_array "$@")
set -- asdf/bootstrap.sh dotfiles/bootstrap.sh
for _bootstrap; do
  curl --silent --retry 3 "${REPO_RAW_URL}/${_bootstrap}" | /bin/bash
done
eval set -- "$args"