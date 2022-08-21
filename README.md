# dotfiles

## policy

* follow [XDF Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)

---

* XDF Base Directory に従う

### common function/binary

* handmade bash
  * interactive use: `$HOME/.bash_function`
    * e.g. open browser, move backup, ...
  * non-interactive use: `$HOME/.local/bin/my_own`
    * e.g. logger, gather_facts ...
* handmade other executables
  * `$HOME/.local/bin/my_own`
* details
  * [local/bin/my_own](my_ownhttps://github.com/Torimune29/dotfiles/tree/main/private_dot_local/bin/my_own)

---

* 自作 bash
  * インタラクティブ用途の場合は `$HOME/.bash_function`へ配置
  * ノンインタラクティブ用途の場合は `$HOME/.local/bin/my_own`へ配置
* 自作のその他実行ファイル
  * `$HOME/.local/bin/my_own`
* 詳細
  * [local/bin/my_own](my_ownhttps://github.com/Torimune29/dotfiles/tree/main/private_dot_local/bin/my_own)

### config

* non handmade application
  * `$HOME/.config`
  * move other config to `$HOME/.config` as far as possible
    * e.g. don't use `$HOME/.gitconfig`, use `$HOME/.config/git/config`
* handmade application/function
  * $HOME/.config/my_own

---

* 自作でないアプリケーションの設定
  * $HOME/.config
  * デフォルトで`$HOME/.config`を使わないものでも、可能な限り$HOME/.configへ配置していく
    * e.g. gitの設定は、`$HOME/.gitconfig`を使わず、`$HOME/.config/git/config`を使用する

### any data

* handmade application/function
  * `$HOME/.local/share/my_own`

---

* 自作アプリ・関数
  * `$HOME/.local/share/my_own`

### log

* handmade application/function
  * `$HOME/.local/state/my_own`
  * <https://stackoverflow.com/questions/25897836/where-should-i-write-a-user-specific-log-file-to-and-be-xdg-base-directory-comp>

---

* 自作アプリ・関数
  * `$HOME/.local/state/my_own`

### secrets

* \*/secrets/\*
