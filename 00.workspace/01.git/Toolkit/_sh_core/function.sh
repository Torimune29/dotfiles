#!/bin/sh

# package manager method
GATHERED_FACTS=false
TOOLKIT_PACKAGE_MANAGER=""
TOOLKIT_PACKAGE_INSTALL=""
TOOLKIT_PACKAGE_UPDATE=""
if ! $GATHERED_FACTS ; then
  if [ -x "$(command -v apt-get)" ];    then TOOLKIT_PACKAGE_MANAGER="apt";    TOOLKIT_PACKAGE_INSTALL="apt-get install -y";     TOOLKIT_PACKAGE_UPDATE="apt-get update"
  elif [ -x "$(command -v yum)" ];      then TOOLKIT_PACKAGE_MANAGER="yum";    TOOLKIT_PACKAGE_INSTALL="yum install -y";         TOOLKIT_PACKAGE_UPDATE="yum check-update"
  elif [ -x "$(command -v dnf)" ];      then TOOLKIT_PACKAGE_MANAGER="dnf";    TOOLKIT_PACKAGE_INSTALL="dnf install -y";         TOOLKIT_PACKAGE_UPDATE="dnf check-update"
  elif [ -x "$(command -v microdnf)" ]; then TOOLKIT_PACKAGE_MANAGER="dnf";    TOOLKIT_PACKAGE_INSTALL="microdnf install -y";    TOOLKIT_PACKAGE_UPDATE="microdnf update"
  elif [ -x "$(command -v zypper)" ];   then TOOLKIT_PACKAGE_MANAGER="zypper"  TOOLKIT_PACKAGE_INSTALL="zypper install -y";      TOOLKIT_PACKAGE_UPDATE="zypper refresh"
  elif [ -x "$(command -v apk)" ];      then TOOLKIT_PACKAGE_MANAGER="apk";    TOOLKIT_PACKAGE_INSTALL="apk add --no-cache";     TOOLKIT_PACKAGE_UPDATE="apk update"
  fi
  GATHERED_FACTS=true
fi

TOOLKIT_USER="$(whoami)"

# internal: get escalation method
get_escalation_method() {
  if [ "${TOOLKIT_USER}" != "root" ]; then
    if [ -x "$(command -v sudo)" ]; then echo "sudo -S -E"
    elif [ -x "$(command -v su)" ]; then echo "su - -c"; fi
  fi
  return 0
}

cat_if_null () {
  [ "$(grep -c "${1}" "${2}")" = "0" ] && echo "${1}" >> "${2}"
}

capture_array () {
  for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
  echo " "
}

exec_in_tmp() {
  [ $# != 1 ] && return 100
  _cwd="$(pwd)"
  _workdir="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf ${_workdir}; cd ${_cwd}" INT PIPE TERM EXIT

  cd "${_workdir}" || exit 1
  eval $1
  cd "${_cwd}" || exit 1

  trap INT PIPE TERM EXIT
  unset _cwd _workdir
}


install_package () {
  if [ -z "$TOOLKIT_PACKAGE_INSTALL" ]; then
    echo "Error: Package manager not found. You must manually install: $_package" >&2
    return 10
  fi
  if [ $# -lt 1 ]; then
    echo "Error: single argument required: package you want to install." >&2
    return 20
  fi
  _package="$*"
  _escalation="$(get_escalation_method)"

  # for debian prompt like tz
  export DEBIAN_FRONTEND=noninteractive

  # install epel for redhat/centos-like distribution
  if [ $TOOLKIT_PACKAGE_MANAGER = "yum" ] || [ $TOOLKIT_PACKAGE_MANAGER = "dnf" ]; then
    if [ -x "$(command -v amazon-linux-extras)" ]; then eval $_escalation amazon-linux-extras install epel
    else eval $_escalation $TOOLKIT_PACKAGE_INSTALL epel-release; fi
  fi
  eval $_escalation $TOOLKIT_PACKAGE_INSTALL $_package

  unset DEBIAN_FRONTEND
  return $?
}

update_repository () {
  if [ -z "$TOOLKIT_PACKAGE_UPDATE" ]; then echo "Error: Package manager not found." >&2; return 1; fi
  _escalation="$(get_escalation_method)"
  set +e ; eval $_escalation $TOOLKIT_PACKAGE_UPDATE ; set -e
  return $?
}

