# dotfiles

## policy

* follow [XDF Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)

### common function/binary

* bash
  * interactive and non-interactive use: $HOME/.bash_function
    * e.g. open browser, move backup, ...
  * non-interactive use only: $HOME/.local/bin
    * e.g. logger, auto-log-rotation, ...

### config

* path: $HOME/.config
  * move other config to $HOME/.config as far as possible
    * e.g. don't use $HOME/.gitconfig, use $HOME/.config/git/config

### log

* path: $HOME/.local/state
  * <https://stackoverflow.com/questions/25897836/where-should-i-write-a-user-specific-log-file-to-and-be-xdg-base-directory-comp>

### secrets

* \*/secrets/\*
