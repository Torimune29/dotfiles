ALIASES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/direnv/lib/bash_function"
export_function() {
  local name=$1
  local alias_dir=${ALIASES_DIR}
  mkdir -p "$alias_dir"
  PATH_add "$alias_dir"
  local target="$alias_dir/$name"
  if declare -f "$name" >/dev/null; then
    echo "#!/usr/bin/env bash" > "$target"
    declare -f "$name" >> "$target" 2>/dev/null
    echo "$name" '"$@"' >> "$target"
    chmod +x "$target"
  fi
}

clear_direnv_aliases() {
  local alias_dir=${ALIASES_DIR}
  rm -rf $alias_dir/*
}

