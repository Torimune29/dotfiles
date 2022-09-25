# dotfiles

This is dotfiles repository, managed by [chezmoi](https://www.chezmoi.io/).

## Testing Platform

[![TestingPlatform](http://github-actions.40ants.com/Torimune29/dotfiles/matrix.svg)](https://github.com/Torimune29/dotfiles)

## Usage

### bootstrap

* curl

```sh
curl --silent https://raw.githubusercontent.com/Torimune29/dotfiles/main/bootstrap.sh | sh

```

### finalize

* Documentation settings
  * vscode-textlint
    * Add **absolute path** `$HOME/.config/textlint/textlintrc` in vscode `settings.json` like,

    ```json
    {
        "textlint.configPath": "/home/me/.config/textlint/textlintrc",
    }
    ```

## policy

* Follow [XDF Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
* Sets my own bin/lib in `my_own` dir. See env on [~/.profile](dot_profile.tmpl)
* Ignore `*/secrets/*` like tokens, product-settings

## TODO

* 全開発環境向けリポジトリ作成とそのfetch

