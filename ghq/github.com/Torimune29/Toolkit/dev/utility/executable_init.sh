#!/bin/bash

set -eu

# reload asdf for non-interactive shell
set +u; . $HOME/.asdf/asdf.sh; set -u

# watchexec
asdf plugin add watchexec https://github.com/nyrst/asdf-watchexec.git || true
asdf install watchexec latest
asdf global watchexec latest

