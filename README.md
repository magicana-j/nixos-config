# NixOS 25.11 flakes + home-manager 環境構築（日本語向け）

このリポジトリは、NixOS 25.11 を flakes + home-manager で運用するための設定一式です。
日本語環境を前提に、Cinnamon デスクトップと fcitx5（mozc）を含む構成を提供します。

## 特長

- 日本語ユーザー向け
- ユニバーサルデザイン日本語フォント、プログラミング向け日本語フォント導入
- 日本語入力: fcitx5（mozc）
- デスクトップ環境: Cinnamon

補足:
ユーザーディレクトリ名（デスクトップ、ダウンロード等）は英語に変更されます。残った日本語名ディレクトリは削除できます。

## 前提

- 対象: NixOS 25.11
- インストール方式: グラフィカル ISO を起動して GUI インストーラでインストールする（ライブインストーラ前提）

## 注意点（重要）

1. ライブインストーラ使用前提（手動インストールは想定外）
   この README は「Graphical ISO で起動 → GUI インストーラでインストール」後に、このリポジトリを適用する流れのみを想定します。
   Minimal ISO での手動インストール（コンソールからインストール）は対象外です。

2. 本リポジトリは Cinnamon を前提に検証しているため、ライブ環境でも Cinnamon を推奨します（他は未検証）
   Graphical ISO はブートメニューでライブ環境のデスクトップを選択できます。

3. flake.nix 編集の際は、ユーザー名をインストール時と揃えてください。
   揃っていないと、ユーザー環境の適用やログイン後の操作が困難になる可能性があります。

## セットアップ手順

### 1. リポジトリをクローン

    cd
    nix-shell -p git --run 'git clone https://github.com/magicana-j/nixos-config'

### 2. setup.sh を実行

    cd ~/nixos-config
    ./setup.sh

### 3. flake.nix を編集

ユーザー名、フルネーム、ホスト名を編集します。
特にユーザー名はインストール時のログイン名と一致させてください。

### 4. nixos-rebuild を実行

    cd ../nixos
    sudo nixos-rebuild switch --flake .#

### 5. 再起動

## 運用（エイリアス）

一度セットアップが成功した後は以下のエイリアスが使えます。

    nrsf
    # sudo nixos-rebuild switch --flake .#ホスト名

    nrb
    # sudo nixos-rebuild dry-build --flake .#ホスト名

## トラブルシュート

### ユーザー名不一致で詰まった場合の復旧手順

症状例:
- ログイン後に環境が壊れている
- home-manager の適用に失敗する
- sudo nixos-rebuild が通らず戻せない
- 設定を直したいのに操作が進まない

基本方針:
- まず「インストール時に作成したユーザー名」と「flake.nix 側のユーザー名」を一致させてから、再度 rebuild します。

手順:

1) TTY に入る
- 画面が不安定なら Ctrl + Alt + F3 などで TTY に切り替えます（F2 から F6 でも可）
- インストール時に作成したユーザーでログインします

2) flake.nix を修正する
- 設定リポジトリの場所へ移動して flake.nix を開きます
  例:
    cd ~/nixos-config
    nano flake.nix
- ユーザー名を、インストール時のログイン名に合わせます
- homeDirectory などユーザー名に依存する設定があれば同様に揃えます
- ホスト名に合わせて flake の出力名も確認します（ホスト名指定を使う場合）

3) もう一度 rebuild する
- 例（リポジトリの構成に合わせてパスは読み替えてください）:
    cd ~/nixos
    sudo nixos-rebuild switch --flake .#ホスト名

4) それでもダメならロールバックする
- 直前の世代に戻す:
    sudo nixos-rebuild switch --rollback
- 再起動後にログインし、落ち着いて flake.nix を直してから再適用します

5) ブートローダから前世代で起動する（最終手段）
- 起動時のブートメニュー（systemd-boot や GRUB）で、古い Generation を選んで起動します
- 起動できた世代から flake.nix を修正し、再度 switch を実行します

補足:
- ユーザー名を変えたい場合は、OS 側のユーザー作り直しやホームの移行も絡むため、まずは「インストール時ユーザー名と揃える」状態に戻してから作業してください。