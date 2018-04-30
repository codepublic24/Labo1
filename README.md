# labo1

実験用プロジェクト(host:Windows)

## Description 

環境構築、スクリプト、テンプレートなど  
実験中プロジェクトを置いています。

## Work Flow

- 各種アカウント作成(必要であれば)
  - [GitHub](https://github.com/join?source=header-home/)
  - [Twitter](https://twitter.com/signup?lang=ja)
  - [Domain:お名前.com](https://px.a8.net/svt/ejp?a8mat=2TNCI2+40OCS2+50+2HFY7M)

- ソフトウェアのインストール
  - [Visual Studio Code(以後、VSCode)](https://code.visualstudio.com/download)
  - [Git for Windows(VS Codeで入るはず)](https://gitforwindows.org/)

- ソフトウェア構成管理の準備(SCM)]
  - [リポジトリの作成](https://github.com/new)
    - New repositryを押下
      - ![new repository](https://github.com/codepublic24/static-image/blob/master/img-gtihub-01.JPG)
    - リポジトリ名を設定
      - ![repository name](https://github.com/codepublic24/static-image/blob/master/img-gtihub-02.JPG)
    - READMEを自動でつくる＋ライセンスの設定
      - ![initialize](https://github.com/codepublic24/static-image/blob/master/img-gtihub-03.JPG)

- VSCodeの設定変更１
  - 統合ターミナルをGitBashに変更  
    [Ctrl + ,]押下後ユーザ- 設定に以下を記載
    -     "terminal.external.windowsExec": "C:\\Program Files\\Git\\bin\\bash.exe",
          "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe"
  - 統合ターミナルの再起動  
    [Ctrl + @]押下後[exit]を入力しターミナルを終了  
    再度[Ctrl + @]を入力しターミナル再起動  
    GitBashに変更されれば成功

 - Gitクライアントの設定  
   (コマンドを選択してコマンドパレットでtrsを入力すると楽)
   - ユーザー情報の設定
   -     git config --global user.email 'メールアドレス'
         git config --global user.name '名前'
   - コミット時の改行コード変換(false=無効)
   -     git config --global core.autocrlf false
   - UTF-8の日本語コメント表示設定
   -     git config --global core.quotepath false
   - SSH(秘密鍵、公開鍵)の作成
   -     mkdir ~/.ssh  
         cd ~/.ssh
         ssh-keygen -t rsa -C 'メールアドレス'
         chmod 600 id_rsa
         clip < ~/.ssh/id_rsa.pub
   - GitHubのアカウント設定から作成した公開鍵を設定
     - ![account setting1](https://github.com/codepublic24/static-image/blob/master/img-gtihub-04.JPG)
     - ![account setting2](https://github.com/codepublic24/static-image/blob/master/img-gtihub-05.JPG)
     - ![account setting3](https://github.com/codepublic24/static-image/blob/master/img-gtihub-06.JPG)
     - ![account setting4](https://github.com/codepublic24/static-image/blob/master/img-gtihub-07.JPG)
 
 - リポジトリのクローン
  -     cd <作業ディレクトリ>
        git clone git@github.com:codepublic24/Labo1.git

## Anything Else

- memo
  - [VSCode]
    - コマンドパレット
      - Ctrl + Shift + p
    - 選択部分のコマンド実行
      - Ctrl + Shift + P, t, r, s
    - mdファイルのプレビュー
      - Ctrl + k, v
  - [Bash]
    - 履歴の編集
      - vi ~/.bash_history
  - [Git]
    - show/diff関係
      - 確認
        - git diff
      - 確認(ファイル指定)
        - git diff -- <ファイルパス>
      - 確認(git addした後)
        - git diff --cached
      - 確認(コミット済み)
        - git show <ハッシュ>
    - commit関係
      - １行ログ
        - git commit -m "コメント"
      - １行ログ ファイル指定
        - git commit -m "コメント" -- <ファイルパス１>  <ファイルパス２>
      - ３行ログ
        - git commit -m "コメント" -m "" -m "詳細説明"
    - log関係
      - 簡易表示
        - git log --oneline
    - rebase関係
      - 修正したいハッシュ＋１を指定
        - git rebase -i <ハッシュ>
      - 中止
        - git rebase --abort
    - stash関係
      - 形式
        - <stash名>: WIP on <stashを行ったブランチ名>: <ハッシュ> <コミットコメント> 
      - 保存
        - git stash
      - 保存(メモ付き)
        - git stash save "message"
      - 確認
        - git stash list
      - 確認(パッチ形式)
        - git stash list -p
      - 取り出し＋削除
        - git stash pop <stash名>
      - 取り出し
        - git stash apply <stash名>
      - 削除
        - git stash drop <stash名>
      - 全削除
        - git stash clear
    - global関係
      - リポジトリのURL確認
        - git remote -v
      - httpsでclone後、originをsshへ変更
        - git remote set-url origin git@github.com:codepublic24/Labo1.git
      - 確認
        - git config --global --list
    - ignore関係
      - テンプレート
        - [ここを参照](https://github.com/github/gitignore/tree/master/Global)
    - hook関係
      - リポジトリ内の[Settings] - [Webhooks]


## Author

[@codepublic24](https://twitter.com/codepublic24)

## License

[MIT](https://github.com/codepublic24/Labo1/blob/master/LICENSE)


