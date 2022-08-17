#!/bin/bash

set -eu

BASE_DIR="$(cd $(dirname $0)/; pwd)"

# reload asdf for non-interactive shell
set +u; . $HOME/.asdf/asdf.sh; set -u

# install tools using asdf
if [ ! -x "$(command -v direnv)" ]; then
  asdf plugin-add direnv || true
  asdf direnv setup --shell bash --version latest
  asdf global direnv latest
fi
if [ ! -x "$(command -v chezmoi)" ]; then
  asdf plugin add chezmoi || true
  asdf install chezmoi latest
  asdf global chezmoi latest
fi

# set current env
[ -e "${BASE_DIR}/.envrc" ] && direnv allow

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
