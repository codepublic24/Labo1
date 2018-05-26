# Labo1

実験用プロジェクト(host:Windows)

## Description

環境構築、スクリプト、テンプレートなど  
実験中プロジェクトを置いています。

## Feature
  - [x] davidhouchin.whitespace-plus-0.0.5
    - VSCode拡張：スペース、タブの色付け
  - [x] git-foresta
    - Perlスクリプト：gitツリーをCLIで表示できる
  - [x] html5_simple_template
    - htmlのスケルトンテンプレート
  - [ ] aws-cfm-vpc
    - AWS上にVPCを作成するCloudFprmation設定ファイル
  - [ ] aws-cfm-ec2
    - AWS上にEC2を作成するCloudFprmation設定ファイル
  - [ ] redmine
    - Redmine構成スクリプト

## Work Flow

- **各種アカウント作成(必要であれば)**
  - [GitHub](https://github.com/join?source=header-home/)
  - [Twitter](https://twitter.com/signup?lang=ja)
  - [Domain:お名前.com](https://px.a8.net/svt/ejp?a8mat=2TNCI2+40OCS2+50+2HFY7M)
  - [AWS](https://console.aws.amazon.com/console/home)

- **ソフトウェアのインストール**
  - [Visual Studio Code(以後、VSCode)](https://code.visualstudio.com/download)
    - インストーラー
  - [Git for Windows(VS Codeで入るはず)](https://gitforwindows.org/)
    - インストーラー
  - [git-foresta](https://github.com/takaaki-kasai/git-foresta)
    - git-forestaを以下にコピー
      - C:\Program Files\Git\usr\bin
      - C:\Program Files\Git\mingw64\bin
  - [Whitespace+](https://marketplace.visualstudio.com/items?itemName=davidhouchin.whitespace-plus)
    - [Ctrl + Shift + x]押下後、[Whitespace+]をインストール
    - [Ctrl + Shift + p]押下後、[Whitespace+ Config]を実行
      - [davidhouchin.whitespace-plus-0.0.5/config.json]の内容で上書き
  - [vscode-icon](hhttps://marketplace.visualstudio.com/items?itemName=robertohuertasm.vscode-icons)
    - [Ctrl + Shift + x]押下後、[vscode-icon]をインストール、再読込
  - [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
    - [Ctrl + Shift + x]押下後、[vscode-icon]をインストール、再読込
 - [Python(3.5 or 3.6)]
    - [3.5.3はこちら](https://www.python.org/downloads/release/python-353/)
      [3.6.5はこちら](https://www.python.org/downloads/release/python-365/)
    - pipのバージョンアップ
      - python -m pip install --upgrade pip
        (pipがない場合：  
         curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"  
         python get-pip.py)
  - [AWS CLI](https://docs.aws.amazon.com/ja_jp/streams/latest/dev/kinesis-tutorial-cli-installation.html)
    - Pythonのpipを使用
      - pip install awscli
    - AWSコンソールでIAMを作成 Credential情報を取得しておく
      - ![aws init01](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-01.JPG)  
        AWSサービスで「IAM」を検索、IAMのページへ遷移  
        ![aws init02](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-02.JPG)  
        ![aws init03](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-03.JPG)  
        管理者グループの作成  
        ![aws init04](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-04.JPG)  
        管理者グループにフルコントロールの権限を付与  
        ![aws init05](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-05.JPG)  
        ![aws init06](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-06.JPG)  
        管理者グループにIAMユーザーを追加  
        ![aws init07](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-07.JPG)  
        Credentialを保存
    - インストール後Credentialの設定(誤接続を防ぐためProfileを使用)
      - aws configure --profile <わかりやすく打ちやすいプロファイル名>  
        ![aws init08](https://github.com/codepublic24/static-image/blob/master/imgset002/img-aws-config-08.JPG)  
        保存していたCredential情報を入力

- **ソフトウェア構成管理の準備(SCM)]**
  - [リポジトリの作成](https://github.com/new)
    - New repositryを押下  
      ![new repository](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-01.JPG)
    - リポジトリ名を設定  
      ![repository name](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-02.JPG)
    - READMEを自動でつくる＋ライセンスの設定  
      ![initialize](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-03.JPG)

- **VSCodeの設定変更１**
  - 統合ターミナルをGitBashに変更  
    ※[Ctrl+Shift+p],[tsds]→Bashを選択でも可
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
    (クローンしたリポジトリのみ違うアカウントの場合はglobalをはずす)
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
    ![account setting1](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-04.JPG)  
    ![account setting2](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-05.JPG)  
    ![account setting3](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-06.JPG)  
    ![account setting4](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-07.JPG)  

  - リポジトリのクローン
    ```Bash
    cd <作業ディレクトリ>
    git clone git@github.com:codepublic24/Labo1.git
    ```

  - Github Flowに従ってPRの作成(wip=work in progress=作業中)
    ```Bash
    git checkout -b <feature-xxx|bugfix-xxx|topic-xxx/#ticketID>
    git branch
    git commit --allow-empty -m "[wip]トピックブランチの簡易説明"
    git push -f origin <feature-xxx|bugfix-xxx|topic-xxx/#ticketID>
    ```
    GitHubのWebページへ移動  
    ![github flow PR1](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-08.JPG)  
    PRを作成  
    ![github flow PR1](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-09.JPG)  
    タイトルに[wip]＋作業説明を記載  
    ![github flow PR1](https://github.com/codepublic24/static-image/blob/master/imgset001/img-github-10.JPG)  
    作業開始PRを発行  
    ```Bash
    作業実施、コミット、PUSH前にリベースでwipをDrop or (#で)コメント化  
    もしくは --amendで上書きしていく
    git commit -a -m "[add]分割した作業名"
    git rebase -i <@~{wip含めたコミット回数}>
    git push -f origin <feature-xxx|bugfix-xxx|topic-xxx/#ticketID>
    ```
    PRを修正して、マージPRを発行
    あとはマージ担当(管理者)が作業
    ```Bash
    マージ完了後、ローカルリポジトリを削除、リモートはマージ担当(管理者)が削除
    git branch --delete <feature-xxx|bugfix-xxx|topic-xxx/#ticketID>
    git remote prune origin
    git branch -a
    ```
    

## Anything Else

- *memo*
  - **[VSCode]**
    - コマンドパレット
      - Ctrl + Shift + p
    - 選択部分のコマンド実行
      - Ctrl + Shift + P, t, r, s
    - mdファイルのプレビュー(別パネル、別タブ)
      - Ctrl + k, v
      - Ctrl + Shift + v
  - **[Bash]**
    - 履歴の編集
      - vi ~/.bash_history
  - **[Git]**
    - remote関係
      - リモートのURL確認
        - git remote -v
      - ローカルでGit作業して、後からリモートを作成した場合
        - git remote add origin git@github.com:codepublic24/<WebGUIで作成したリポジトリ名>.git
      - httpsでclone後、originをsshへ変更
        - git remote set-url origin git@github.com:codepublic24/Labo1.git
      - origin という名称で登録されているリモートリポジトリを削除(登録の解除)
        - git remote rm origin
      - git branch -aで消したはずのリモートリポジトリが表示される
        - git remote prune origin
        - git branch -a
    - show/diff関係
      - 確認
        - git diff
      - 確認(ファイル指定)
        - git diff -- <ファイルパス>
      - 確認(git addした後)
        - git diff --cached
      - 確認(最後のコミット)
        - git diff @^
      - 確認(特定のコミットの差分)
        - git diff <ハッシュ>
      - 特定のコミット同士の比較
        - git diff <ハッシュA>..<ハッシュB> 
      - 特定のコミット情報を確認
        - git show <ハッシュ>
    - add関係
      - ファイルを指定してステージング
        - git add <ファイル名>
      - 全変更をインデックスへ登録＝ステージング
        - git add .
      - ファイルを編集して、部分的にステージング
        - git add -p <ファイル名>
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
      - git-forestaをインストールしている場合
        - git-foresta --all
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
      - 間違ってコミットしてPUSHしてしまった場合(戻したことを履歴として残す)
        - git revert @^
        - git push -f origin <master or ブランチ名>
      - (非推奨)間違ってコミットしてPUSHしてしまった場合(戻したことを履歴として残さない)
        - git reset --hard @^
        - git push -f origin <master or ブランチ名>
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
          git merge <マージ元のブランチ>
      - ブランチの作業をmasterへマージ(マージコミットを作らない)(Confictが発生している場合)
        - git checkout master  
          git merge --ff <マージ元のブランチ>  
          git status  
          vi <Conflictの発生しているファイル>  
          git add <Conflictを解消したファイル>  
          git commit -m "[merge]fixed conflict" -m "" -m "マージの説明(機能説明、ハッシュ等)"
      - ブランチの作業をmasterへマージ(マージコミットを作る)(Confictが発生している場合)
        - git checkout master  
          git merge --no-ff <マージ元のブランチ>  
          git status  
          vi <Conflictの発生しているファイル>  
          git add <Conflictを解消したファイル>  
          git commit -m "[merge]fixed conflict"
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

  - **[Cmd]**
    - Windowsコマンドラインの文字コードをUTF8へ
      - chcp 65001
    - Windowsコマンドラインの文字コードをSHIFT-JISへ
      - chcp 932

  - **[AWS]**
    - |コード |名前|
      |:---|:---|
      |us-east-1|米国東部（バージニア北部）|
      |us-east-2|米国東部 (オハイオ)|
      |us-west-1|米国西部 (北カリフォルニア)|
      |us-west-2|米国西部 (オレゴン)|
      |ca-central-1|カナダ (中部)|
      |eu-central-1|欧州 (フランクフルト)|
      |eu-west-1|欧州 (アイルランド)|
      |eu-west-2|欧州 (ロンドン)|
      |eu-west-3|EU (パリ)|
      |ap-northeast-1|アジアパシフィック (東京)|
      |ap-northeast-2|アジアパシフィック (ソウル)|
      |ap-northeast-3|アジアパシフィック (大阪: ローカル)|
      |ap-southeast-1|アジアパシフィック (シンガポール)|
      |ap-southeast-2|アジアパシフィック (シドニー)|
      |ap-south-1|アジアパシフィック (ムンバイ)|
      |sa-east-1|南米 (サンパウロ)|


## Author

[@codepublic24](https://twitter.com/codepublic24)

## License

[MIT](https://github.com/codepublic24/Labo1/blob/master/LICENSE)


