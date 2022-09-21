#!/usr/bin/env bash

set -e

. $HOME/.local/bin/my_own/_log
. $HOME/.local/bin/my_own/_gather_facts

readonly GHQ_WORKSPACE_PATH="$HOME/ghq/github.com/Torimune29"
readonly MY_GITHUB_WORKSPACE_PATH="$HOME/gh-workspace"

print_script_info

# link self ghq folder to HOME(reveal prevention)
mkdir -p "$GHQ_WORKSPACE_PATH"
[ -z "$MY_GITHUB_WORKSPACE_PATH" ] && ln -s "$GHQ_WORKSPACE_PATH" "$MY_GITHUB_WORKSPACE_PATH"

# document workspace
{{ if not (lookPath "chezmoi") -}}
# chezmoi
asdf plugin add chezmoi || true
asdf install chezmoi ${versions["chezmoi"]}
asdf global chezmoi ${versions["chezmoi"]}
{{ end -}}

{{ if not (lookPath "direnv") -}}
# dienv
asdf plugin-add direnv || true
asdf direnv setup --shell bash --version ${versions["direnv"]}
asdf global direnv ${versions["direnv"]}
{{ end -}}

{{ if not (lookPath "bat") -}}
# bat
asdf plugin add bat || true
asdf install bat ${versions["bat"]}
asdf global bat ${versions["bat"]}
{{ end -}}

{{ if not (lookPath "rg") -}}
# ripgrep
asdf plugin add ripgrep || true
asdf install ripgrep ${versions["ripgrep"]}
asdf global ripgrep ${versions["ripgrep"]}
{{ end -}}

{{ if not (lookPath "exa") -}}
# exa
asdf plugin add exa || true
asdf install exa ${versions["exa"]}
asdf global exa ${versions["exa"]}
{{ end -}}

{{ if not (lookPath "zoxide") -}}
# zoxide
asdf plugin add zoxide https://github.com/nyrst/asdf-zoxide.git || true
asdf install zoxide ${versions["zoxide"]}
asdf global zoxide ${versions["zoxide"]}
{{ end -}}

{{ if not (lookPath "delta") -}}
# delta
asdf plugin add delta || true
asdf install delta ${versions["delta"]}
asdf global delta ${versions["delta"]}
{{ end -}}

{{ if not (lookPath "starship") -}}
# starship
asdf plugin add starship || true
asdf install starship ${versions["starship"]}
asdf global starship ${versions["starship"]}
{{ end -}}

{{ if not (lookPath "fd") -}}
# fd
asdf plugin add fd || true
asdf install fd ${versions["fd"]} 1>/dev/null
asdf global fd ${versions["fd"]}
{{ end -}}

{{ if not (lookPath "fzf") -}}
# fzf
asdf plugin add fzf https://github.com/kompiro/asdf-fzf.git || true
asdf install fzf ${versions["fzf"]}
asdf global fzf ${versions["fzf"]}
# fzf-tab-completion
rm -rf $HOME/.local/share/fzf > /dev/null 2>&1
mkdir -p $HOME/.local/share/fzf
curl --silent -o $HOME/.local/share/fzf/fzf-bash-completion.sh https://raw.githubusercontent.com/lincheney/fzf-tab-completion/master/bash/fzf-bash-completion.sh
{{ end -}}

{{ if not (lookPath "ghq") -}}
# ghq
asdf plugin-add ghq https://github.com/kajisha/asdf-ghq || true
asdf install ghq ${versions["ghq"]} || true
asdf global ghq ${versions["ghq"]} || true
{{ end -}}

{{ if not (lookPath "gh") -}}
# github-cli
asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git || true
asdf install github-cli ${versions["github-cli"]} 1>/dev/null
asdf global github-cli ${versions["github-cli"]}
{{ end -}}

{{ if not (lookPath "gojq") -}}
# gojq
asdf plugin-add jq https://github.com/jimmidyson/asdf-gojq.git || true
asdf install jq ${versions["gojq"]}
asdf global jq ${versions["gojq"]}
{{ end -}}

{{ if not (lookPath "watchexec") -}}
# watchexec
asdf plugin add watchexec https://github.com/nyrst/asdf-watchexec.git || true
asdf install watchexec ${versions["watchexec"]}
asdf global watchexec ${versions["watchexec"]}
{{ end -}}

{{ if not (lookPath "navi") -}}
# navi
curl -L https://github.com/denisidoro/navi/releases/download/${versions["navi"]}/navi-${versions["navi"]}-x86_64-unknown-linux-musl.tar.gz | tar xz -C $HOME/.local/bin/
{{ end -}}

{{ if not (lookPath "nvim") -}}
# neovim
asdf plugin add neovim || true
asdf install neovim ${versions["neovim"]}
asdf global neovim ${versions["neovim"]}
{{ end -}}

{{ if not (lookPath "tmux") -}}
# tmux
curl -L -o $HOME/.local/bin/tmux https://github.com/pythops/tmux-linux-binary/releases/download/${versions["tmux"]}/tmux
chmod +x $HOME/.local/bin/tmux
{{ end -}}

{{ if not (lookPath "fpp") }}
# fpp
rm -rf $HOME/.local/bin/fpp ${XDG_DATA_HOME:-$HOME/.local/share}/PathPicker > /dev/null 2>&1
git clone --depth=1 https://github.com/facebook/PathPicker.git ${XDG_DATA_HOME:-$HOME/.local/share}/PathPicker -b ${versions["fpp"]}
pushd ${XDG_DATA_HOME:-$HOME/.local/share}/PathPicker > /dev/null 2>&1 || exit
ln -s "$(pwd)/fpp" $HOME/.local/bin/fpp
popd > /dev/null 2>&1 || exit
{{ end -}}

{{ if not (lookPath "semver") -}}
# semver
asdf plugin add semver || true
asdf install semver ${versions["semver"]}
asdf global semver ${versions["semver"]}
{{ end -}}

log_success "$0 done."
