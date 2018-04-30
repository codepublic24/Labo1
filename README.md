# labo1

実験用プロジェクト(host:Windows)

## Description 

環境構築、スクリプト、テンプレートなど  
実験中プロジェクトを置いています。

## Work Flow

- **各種アカウント作成(必要であれば)**
  - [GitHub](https://github.com/join?source=header-home/)
  - [Twitter](https://twitter.com/signup?lang=ja)
  - [Domain:お名前.com](https://px.a8.net/svt/ejp?a8mat=2TNCI2+40OCS2+50+2HFY7M)

- **ソフトウェアのインストール**
  - [Visual Studio Code(以後、VSCode)](https://code.visualstudio.com/download)
  - [Git for Windows(VS Codeで入るはず)](https://gitforwindows.org/)

- **ソフトウェア構成管理の準備(SCM)]**
  - [リポジトリの作成](https://github.com/new)
    - New repositryを押下  
      ![new repository](https://github.com/codepublic24/static-image/blob/master/img-gtihub-01.JPG)
    - リポジトリ名を設定  
      ![repository name](https://github.com/codepublic24/static-image/blob/master/img-gtihub-02.JPG)
    - READMEを自動でつくる＋ライセンスの設定  
      ![initialize](https://github.com/codepublic24/static-image/blob/master/img-gtihub-03.JPG)

- **VSCodeの設定変更１**
  - 統合ターミナルをGitBashに変更  
    [Ctrl + ,]押下後ユーザ- 設定に以下を記載
    ```Bash
    "terminal.external.windowsExec": "C:\\Program Files\\Git\\bin\\bash.exe",
    "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe"
    ```
  - 統合ターミナルの再起動  
    [Ctrl + @]押下後[exit]を入力しターミナルを終了  
    再度[Ctrl + @]を入力しターミナル再起動  
    GitBashに変更されれば成功

- **Gitクライアントの設定**  
   (コマンドを選択してコマンドパレットでtrsを入力すると楽)
  - ユーザー情報の設定
    ```Bash
    git config --global user.email 'メールアドレス'
    git config --global user.name '名前'
    ```
  - コミット時の改行コード変換(false=無効)
    ```Bash
    git config --global core.autocrlf false
    ```
  - UTF-8の日本語コメント表示設定
    ```Bash
    git config --global core.quotepath false
    ```
  - SSH(秘密鍵、公開鍵)の作成
    ```Bash:GitBash
    mkdir ~/.ssh  
    cd ~/.ssh
    ssh-keygen -t rsa -C 'メールアドレス'
    chmod 600 id_rsa
    clip < ~/.ssh/id_rsa.pub
    ```
  - GitHubのアカウント設定から作成した公開鍵を設定  
    ![account setting1](https://github.com/codepublic24/static-image/blob/master/img-gtihub-04.JPG)  
    ![account setting2](https://github.com/codepublic24/static-image/blob/master/img-gtihub-05.JPG)  
    ![account setting3](https://github.com/codepublic24/static-image/blob/master/img-gtihub-06.JPG)  
    ![account setting4](https://github.com/codepublic24/static-image/blob/master/img-gtihub-07.JPG)  
 
  - リポジトリのクローン
    ```Bash
    cd <作業ディレクトリ>
    git clone git@github.com:codepublic24/Labo1.git
    ```

## Anything Else

- *memo*
  - **[VSCode]**
    - コマンドパレット
      - Ctrl + Shift + p
    - 選択部分のコマンド実行
      - Ctrl + Shift + P, t, r, s
    - mdファイルのプレビュー
      - Ctrl + k, v
  - **[Bash]**
    - 履歴の編集
      - vi ~/.bash_history
  - **[Git]**
    - show/diff関係
      - 確認
        - git diff
      - 確認(ファイル指定)
        - git diff -- <ファイルパス>
      - 確認(git addした後)
        - git diff --cached
      - 確認(特定のコミットの差分)
        - git show <ハッシュ>
    - commit関係
      - １行ログ
        - git commit -m "コメント"
      - １行ログ ファイル指定
        - git commit -m "コメント" -- <ファイルパス１>  <ファイルパス２>
      - １行ログ＋add(ステージング)省略
        - git commit -a -m "コメント"
      - ３行ログ
        - git commit -m "コメント" -m "" -m "詳細説明"
      - ３行ログ ファイル指定
        - git commit -m "コメント" -m "" -m "詳細説明" -- <ファイルパス１>  <ファイルパス２>
      - ３行ログ＋add(ステージング)省略
        - git commit -a -m "コメント" -m "" -m "詳細説明"
      - コミットコメントのプレフィックス
        - add：新規ファイル/機能追加
        - change：仕様変更
        - update：機能修正（バグではない）
        - fix：バグ修正
        - hotfix：クリティカルなバグ修正
        - merge：マージ
        - remove：削除（ファイル）
        - clean：整理（リファクタリング等）
        - disable：無効化（コメントアウト等）
        - upgrade：バージョンアップ
        - revert：変更取り消し
    - reset/reflog関係(@^=HEAD^=HEADから一つ前)
      - 作業中の状態を破棄(最終コミットの状態に戻す)
        - git reset --soft @
      - 最後のコミットを削除(変更部分は残したまま)
        - git reset --soft @^
      - 作業中の状態を破棄(変更部分も消す)(最終コミットの状態に戻す)
        - git reset --hard @
      - 最後のコミットを削除(変更部分も消す)
        - git reset --hard @^
      - 特定のコミットまで削除(指定のコミットは消えない、変更部分は残したまま)
        - git reset --soft <ハッシュ>
      - 特定のコミットまで削除(指定のコミットは消えない、変更部分も消す)
        - git reset --hard <ハッシュ>
      - 間違ってresetした場合(HEAD@{1}=直前の操作)
        - git reflog  
          git reset <シンボル>
    - log関係
      - 簡易表示(ローカルカレント)
        - git log --oneline
      - ツリー表示(ローカルカレント)
        - git log --oneline --graph --decorate
      - 簡易表示(ローカルのすべて)
        - git log --oneline --all
      - ツリー表示(ローカルのすべて)
        - git log --oneline --graph --decorate --all
      - ツリー表示(詳細)(ローカルのすべて)
        - git log --oneline --graph --decorate --all -p
    - rebase関係
      - 修正したいハッシュ＋１を指定  
        fixup(msg破棄)/squas(msg統合)は直前のハッシュに統合
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
    - branch関係
      - ローカルブランチとリモートブランチの一覧を表示
        - git branch --all
      - ローカルブランチの一覧を表示
        - git branch
      - ローカルブランチを削除
        - git branch --delete <ローカルブランチ名>
      - ローカルブランチを削除(マージチェックを無視)
        - git branch -D <ローカルブランチ名>
      - リモートブランチの一覧を表示
        - git branch --remote
      - リモートブランチを削除
        - git push --delete origin <リモートブランチ名>
      - masterで作業し(ブランチを作り忘れ)てしまった(コミット前)
        - git checkout -b working
      - masterで作業し(ブランチを作り忘れ)てしまった(コミット後 すべてブランチへコピー)
        - git checkout -b working origin/master 
          git merge master
          git checkout master
          git log --oneline
          git reset --hard <戻したいハッシュ>
          git log --oneline --all
      - masterで作業し(ブランチを作り忘れ)てしまった(コミット後 特定の対応のみブランチへコピー)
        - git checkout -b working origin/master 
          git log --oneline master 
          git cherry-pick <master側のハッシュ>
          git checkout master
          git log --oneline
          git reset --hard <戻したいハッシュ>
          git log --oneline --all
      - ブランチの作業をmasterへマージ(Confictが発生していない場合)
        - git checkout master
        - git merge <マージ元のブランチ>
      - ブランチの作業をmasterへマージ(マージ元の履歴を引き継がない)(Confictが発生している場合)
        - git checkout master
        - git merge <マージ元のブランチ>
        - git status
        - vi <Conflictの発生しているファイル>
        - git add <Conflictを解消したファイル>
        - git commit -m "[merge]fixed conflict" -m "" -m "マージの説明(機能説明、ハッシュ等)"
      - ブランチの作業をmasterへマージ(マージ元の履歴を引き継ぐ)(Confictが発生している場合)
        - git checkout master
        - git merge --no-ff <マージ元のブランチ>
        - git status
        - vi <Conflictの発生しているファイル>
        - git add <Conflictを解消したファイル>
        - git commit -m "[merge]fixed conflict" 
      - masterの更新をブランチへ反映(masterを最新へ、その後rebaseで付け替える)
        - git checkout master  
          git pull origin master  
          git checkout working  
          git rebase master  
          ※開発ブランチをリモートに上げている場合且つ更新する場合  
          git push -f origin working
      - ブランチ切り替えができない(Changes not staged for commit)
        - git stash
      - ブランチ切り替えができない(編集ファイルごと初期化)(Changes not staged for commit)
        - git checkout .
      - ブランチ切り替えができない(Untrackd files)
        - git clean -f
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

  - **[Markdown]**
    - エスケープ
      - 「\」をMarkdownの前につけることでMarkdownを無効化
    - 参照
      - MarkdownページのURLに「.md」をつけると記法が見れる
    - テーブル
      - |左揃え|中央揃え|右揃え|
        |:---|:---:|--:|
        |align-left|align-center|align-right|


## Author

[@codepublic24](https://twitter.com/codepublic24)

## License

[MIT](https://github.com/codepublic24/Labo1/blob/master/LICENSE)


