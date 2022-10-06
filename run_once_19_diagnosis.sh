#!/usr/bin/env bash

. $HOME/.local/bin/my_own/_log

. $HOME/.asdf/asdf.sh
PATH="$HOME/.local/bin:$PATH"

declare -A validator=(
  ["asdf"]="asdf --version"
  ["chezmoi"]="chezmoi --version"
  ["direnv"]="direnv --version"
  ["bat"]="bat --version"
  ["ripgrep"]="rg --version"
  ["exa"]="exa --version"
  ["zoxide"]="zoxide --version"
  ["delta"]="delta --version"
  ["starship"]="starship --version"
  ["fd"]="fd --version"
  ["fzf"]="fzf --version"
  ["ghq"]="ghq --version"
  ["github-cli"]="gh --version"
  ["gojq"]="gojq --version"
  ["watchexec"]="watchexec --version"
  ["navi"]="navi --version"
  ["neovim"]="nvim --version"
  ["tmux"]="tmux -V"
  ["fpp"]="fpp --version"
  ["semver"]="semver --version"
  ["gron"]="gron --version"
  ["jc"]="jc --version"
  ["pandoc"]="pandoc --version"
  ["git-crypt"]="git-crypt --version"
  ["mcfly"]="mcfly --version"
  ["monolith"]="monolith --version"
  # ["vifm"]="vifm --version"
  ["s"]="s --version"
  ["hledger"]="hledger --version"
  ["dust"]="dust --version"
  # ["up"]="up --help"
  ["usql"]="usql --version"
  ["hyperfine"]="hyperfine --version"
)

print_script_info

# validate cli tools
log_note "validating cli tools"
for i in "${!validator[@]}"
do
  return_value=1
  eval "${validator[$i]}" > /dev/null 2>&1
  return_value=$?
  if [ $return_value != 0 ]; then
    log_error "$i"
  fi
  unset return_value
done
log_success "validating cli tools done."

# validate shell profile
log_note "validating .profile on interactive"
## TMUX=true for testing profile on docker
/bin/bash -i -c "TMUX=true ; . $HOME/.profile" > /dev/null
if [ $? != 0 ]; then
  log_error ".profile"
  exit 1
fi
log_success "validating .profile on interactive done."

echo ""
log_success "$0 done."