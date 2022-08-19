#!/bin/bash

set -eu

# reload asdf for non-interactive shell
set +u; . $HOME/.asdf/asdf.sh; set -u

# dienv
asdf plugin-add direnv || true
asdf direnv setup --shell bash --version latest
asdf global direnv latest

# chezmoi
asdf plugin add chezmoi || true
asdf install chezmoi latest
asdf global chezmoi latest

# bat
asdf plugin add bat || true
asdf install bat latest
asdf global bat latest

# ripgrep
asdf plugin add ripgrep || true
asdf install ripgrep latest
asdf global ripgrep latest

# exa
asdf plugin add exa || true
asdf install exa latest
asdf global exa latest

# zoxide
asdf plugin add zoxide https://github.com/nyrst/asdf-zoxide.git || true
asdf install zoxide latest
asdf global zoxide latest

# starship
asdf plugin add starship || true
asdf install starship latest
asdf global starship latest

# peco
asdf plugin add peco https://github.com/asdf-community/asdf-peco.git || true
asdf install peco latest
asdf global peco latest

# ghq
asdf plugin-add ghq https://github.com/kajisha/asdf-ghq || true
asdf install ghq latest
asdf global ghq latest

# github-cli
asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git || true
asdf install github-cli latest
asdf global github-cli latest

# gojq
asdf plugin-add jq https://github.com/jimmidyson/asdf-gojq.git || true
asdf install jq latest
asdf global jq latest

# enhancd
[ ! -e "${HOME}/.enhancd" ] && git clone https://github.com/b4b4r07/enhancd $HOME/.enhancd
