#!/usr/bin/env bash

set -e

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
)

print_script_info

result_table=

for i in "${!validator[@]}"
do
  return_value=1
  eval "${array[$i]}"
  return_value=$?
  if [ $return_value = 0 ]; then
    result_table="$result_table$i valid\n"
  else
    result_table="$result_table$i invalid\n"
  fi
  unset return_value
done

echo -e $result_table | column -t
unset result_table

log_success "$0 done."