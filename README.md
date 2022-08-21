# dotfiles

## policy

* follow [XDF Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)

### common function/binary

* handmade bash
  * interactive use: $HOME/.bash_function
    * e.g. open browser, move backup, ...
  * non-interactive use: $HOME/.local/bin/my_own
    * e.g. logger, auto-log-rotation, ...
* handmade other executables
  * $HOME/.local/bin/my_own

### config

* non handmade application
  * $HOME/.config
  * move other config to $HOME/.config as far as possible
    * e.g. don't use $HOME/.gitconfig, use $HOME/.config/git/config
* handmade application/function
  * $HOME/.config/my_own

### any data

* handmade application/function
  * $HOME/.local/share/my_own

### log

* handmade application/function
  * $HOME/.local/state/my_own
  * <https://stackoverflow.com/questions/25897836/where-should-i-write-a-user-specific-log-file-to-and-be-xdg-base-directory-comp>

### secrets

* \*/secrets/\*
