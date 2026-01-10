# NixOS & flakes, home-manager環境構築

- デスクトップ環境：KDE Plasma 6
- 日本語入力ソフトウェア：fcitx5(mozc)

ユーザーディレクトリ名は英語に変更されます。

## セットアップ手順

### クイックスタート（サンプル設定で試す場合）

リポジトリをクローンして、すぐに試すことができます：
```bash
git clone https://github.com/yourusername/nixos-config.git ~/

cd ~/nixos-config
./setup.sh

cd ../nixos
sudo nixos-rebuild switch --flake .#
```

**注意**: この方法では`user-config.nix.example`のデフォルト値が使用されます。
本番環境では必ず以下の「本番環境のセットアップ」を実行してください。

### 本番環境のセットアップ

#### 1. ユーザー設定ファイルの作成

`~/nixos`ディレクトリで

```bash
cp user-config.nix.example user-config.nix
cp git.nix.example git.nix
```

#### 2. 設定ファイルの編集

`user-config.nix`を編集して、自分の環境に合わせて設定します：

```bash
nano user-config.nix

nano git.nix
```

必須の設定項目：
- `myName`: ユーザー名
- `myHostname`: ホスト名
- `userFullName`: フルネーム（Gitなどで使用）
- `userEmail`: メールアドレス

#### 5. 設定の適用

```bash
sudo nixos-rebuild switch --flake .#
```

#### 6. 再起動

一度セットアップが成功したあとは次のコマンドでリビルドできます。

```bash
nsrf
```

### KDE Plasma 6 上でのfcitx5の設定

メニュー - KDE システム設定 - キーボード - 仮想キーボード

で「Fcitx5」を選択し、「適用」をクリックしてください。


## 設定ファイルについて

### 自動フォールバック機能

`user-config.nix`が存在しない場合、システムは自動的に`user-config.nix.example`を読み込みます。
ただし、デフォルト値が使用されるため、ビルド時に警告メッセージが表示されます。

### 推奨される運用方法

1. **初回テスト**: サンプル設定でシステムが動作することを確認
2. **カスタマイズ**: `user-config.nix`を作成して自分の環境に合わせる
3. **本番運用**: カスタマイズした設定で運用

## ファイル管理

Git管理されないファイル：
- `user-config.nix` - 個人設定（各自で作成）
-  git.nix 個人のgit設定（各自で作成）
- `hardware-configuration.nix` - ハードウェア固有設定（各自で生成）

Git管理されるファイル：
- `user-config.nix.example` - サンプル設定
- その他の設定ファイル
