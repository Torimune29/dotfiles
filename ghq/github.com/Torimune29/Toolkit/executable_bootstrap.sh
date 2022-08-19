#!/bin/sh

set -eu

BASE_DIR="$(cd $(dirname $0)/; pwd)"
ORDER="${ORDER:-dev}"

# read .env
[ -e "${BASE_DIR}/.env" ] && . "${BASE_DIR}/.env"
REPO_URL="${REPO_URL:-https://github.com/Torimune29/Toolkit.git}"
REPO_RAW_URL="${REPO_RAW_URL:-https://raw.githubusercontent.com/Torimune29/Toolkit/main}"
BOOTSTRAP_FUNCTION_PATH="${BOOTSTRAP_FUNCTION_PATH:-_bootstrap/function.sh}"

echo ""
echo "[bootstrap start]"
echo ""
echo "ORDER   : ${ORDER}"
echo "REPO_URL: ${REPO_URL}"
echo ""

# find _sh_core/function.sh
if [ -e "${BASE_DIR}/${BOOTSTRAP_FUNCTION_PATH}" ]; then
  # shellcheck source=_sh_core/function.sh
  . "${BASE_DIR}/${BOOTSTRAP_FUNCTION_PATH}"  # use local
  # ready to get toolkit
  update_repository
else  # fetch remote sh/core.sh
  _fetch=""
  if [ -x "$(command -v curl)" ];  then _fetch="curl --silent --retry 3 -O";
  elif [ -x "$(command -v wget)" ];    then _fetch="wget --quiet --tries=3";
  else echo "Error: fetch method not found." >&2; exit 1;
  fi

  # create and move to tmpdir
  _cwd="$(pwd)"
  _workdir="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf ${_workdir}; cd ${_cwd}" INT PIPE TERM EXIT
  cd "${_workdir}" || exit 1
  # fetch core script
  eval "$_fetch" "${REPO_RAW_URL}/${BOOTSTRAP_FUNCTION_PATH}"
  # shellcheck source=/dev/null
  . "${_workdir}/$(basename "${REPO_RAW_URL}"/"${BOOTSTRAP_FUNCTION_PATH}")"
  # install git and checkout Toolkit
  update_repository && install_package git
  git clone --depth=1 ${REPO_URL} && cd "$(basename ${REPO_URL} .git)"
  BASE_DIR=$(pwd)
  unset _fetch _toolkit_core_function_url _toolkit_url
fi

# ready to get Toolkit
install_package bash git curl tar gzip unzip
install_package xz-utils  # for debian
install_package xz  # for redhat


echo ""
echo "[init scripts start]"
echo ""

# call inits
# var check for order.txt without last lf
while read _init_package || [ -n "${_init_package}" ]; do
  while read _init || [ -n "${_init}" ]; do
    /bin/bash "${BASE_DIR}/${_init_package}/${_init}"
  done < "${BASE_DIR}/${_init_package}/order.txt"
done < "${BASE_DIR}/order_${ORDER}.txt"
