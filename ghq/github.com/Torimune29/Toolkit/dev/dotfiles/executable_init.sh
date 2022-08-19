#!/bin/bash

set -eu

BASE_DIR="$(cd $(dirname $0)/; pwd)"

# reload asdf for non-interactive shell
set +u; . $HOME/.asdf/asdf.sh; set -u

# fetch dotfiles
set +u
if [ -n "${DOTFILES_GIT_AUTHOR_NAME}" ]; then
  if ! curl --silent --fail https://api.github.com/repos/${DOTFILES_GIT_AUTHOR_NAME}/dotfiles > /dev/null 2>&1; then
    echo "Error: dotfiles repository not found." >&2
    exit 20
  fi
  chezmoi init https://github.com/${DOTFILES_GIT_AUTHOR_NAME}/dotfiles.git
  chezmoi apply -v
fi
set -u
