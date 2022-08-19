#!/bin/bash

set -eu

ASDF_VERSION="v0.10.2"
ASDF_SHELL_SNIPPETS=(". \$HOME/.asdf/asdf.sh" ". \$HOME/.asdf/completions/asdf.bash")
ASDF_SHELL_RC_PATH="$HOME/.bashrc"

cat_if_null () {
  if [ "$(grep -c "${1}" "${2}")" = "0" ]; then echo -e "${1}" >> "${2}"; fi
}

# install asdf
if [ ! -x "$(command -v asdf)" ] && [ ! -e "$HOME/.asdf" ]; then
  git clone --depth=1 https://github.com/asdf-vm/asdf.git $HOME/.asdf -b ${ASDF_VERSION}
  touch ${ASDF_SHELL_RC_PATH}  # for root
  for i in "${ASDF_SHELL_SNIPPETS[@]}"; do cat_if_null "${i}" "${ASDF_SHELL_RC_PATH}"; done
fi

