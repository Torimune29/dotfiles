# .local/bin/my_own

## policy

* bash
  * 共通
    * shebang
      * sh対応なものとbashのみ対応のものは区別する。sh_bandlerなどでsh対応なスクリプトが作れるかどうかを識別するため
  * 関数
    * 命名規則
      * _(関数名)
        * 単独実行可能なスクリプトと区別するため
    * 実装方針
      * ユーザ定義のグローバルな環境変数(`$HOME/.profile`などで定義されるもの)は使用しない
        * モジュール可搬性を高めるため
  * スクリプト本体
    * 命名規則
      * (シェル名)
    * 実装方針
      * ユーザ定義のグローバルな環境変数(`$HOME/.profile`などで定義されるもの)は使用してもよい
        * モジュール可搬性を損ねるが、可搬なものを関数化する方針とする

## Description/idiom

* bash

名前 | 説明 | 使用イディオム |
--- | --- | --- |
_color | 色表示 | カラーコード |
_log | 色表示・syslog対応ログ | printf でのエスケープシーケンス込み出力<br>端末の横幅までログ出力 |
_gather_facts | 環境詳細情報取得 | 関数で複数の値を返す。 |
_debug | ステップ実行機能挿入 | DEBUGシグナルのtrap(bashのみ) |
bash_wrapper | 各種エラーハンドリング設定付きbash実行 | エラーハンドリング<br>引数のshift |
sh_bundler | シェルファイルの結合 | - |
wsl_notify | wsl→windowsへの通知 | trap による一時ファイル後始末<br>wsl⇔Windows間ファイルシステムパス変換<br>wslからのpowershell実行 |
daemon | nohupのラッパ | nohup制御（標準入力のケア） |

