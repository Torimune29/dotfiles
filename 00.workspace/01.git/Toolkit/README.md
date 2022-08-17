# Toolkit

![Actions](https://github.com/Torimune29/Toolkit/actions/workflows/bootstrap.yml/badge.svg)

The Toolkit is a set of development tools and their installers.

Toolkitは、開発のためのツールと、そのインストーラのセットです.

- [Toolkit](#toolkit)
  - [Tools installed](#tools-installed)
    - [bootstrap](#bootstrap)
  - [Platform being tested](#platform-being-tested)
  - [Installation](#installation)
    - [bootstrap](#bootstrap-1)
      - [Prerequisite](#prerequisite)
      - [How to use](#how-to-use)
        - [Simple](#simple)
        - [With dotfiles repository sync](#with-dotfiles-repository-sync)

## Tools installed

インストールされるツール

### bootstrap

Name | URL |
--- | --- |
asdf | <https://github.com/asdf-vm/asdf>  |
direnv(asdf) | <https://github.com/direnv/direnv><br><https://github.com/asdf-community/asdf-direnv>|
chezmoi(asdf) | <https://github.com/twpayne/chezmoi><br><https://github.com/joke/asdf-chezmoi> |

## Platform being tested

テストしているプラットフォーム

[![](http://github-actions.40ants.com/Torimune29/Toolkit/matrix.svg?only=bootstrap,distro)](https://github.com/Torimune29/Toolkit)

[Details(Github Action workflow)](https://github.com/Torimune29/Toolkit/blob/main/.github/workflows/bootstrap.yml)

## Installation

### bootstrap

#### Prerequisite

* sh
* sudo
* wget or curl

#### How to use

##### Simple

* wget

```sh
wget --quiet -O - https://raw.githubusercontent.com/Torimune29/Toolkit/main/bootstrap.sh | sudo sh

```

* curl

```sh
curl --silent https://raw.githubusercontent.com/Torimune29/Toolkit/main/bootstrap.sh | sudo sh

```

##### With dotfiles repository sync

If ```DOTFILES_GIT_AUTHOR_NAME``` environment valriable sets, bootstrap syncs github repository ```${DOTFILES_GIT_AUTHONR_NAME}/dotfiles``` using [chezmoi](https://github.com/twpayne/chezmoi)

```sh
wget --quiet -O - https://raw.githubusercontent.com/Torimune29/Toolkit/main/bootstrap.sh | DOTFILES_GIT_AUTHOR_NAME=Torimune29 sudo -E sh

```
