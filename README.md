# NixOS & flakes, home-manager環境構築

- デスクトップ環境：Cinnamon
- 日本語入力ソフトウェア：fcitx5(mozc)

ユーザーディレクトリ名は英語に変更されます。

## セットアップ手順

```bash
git clone https://github.com/yourusername/nixos-config.git ~/

cd ~/nixos-config
./setup.sh
```

### 設定ファイルの編集

設定項目：
- `myName`: ユーザー名
- `myHostname`: ホスト名
- `userFullName`: フルネーム
- `userEmail`: メールアドレス（Gitで使用）

### Gitユーザー設定ファイルを作る

#### 設定ファイルのコピー

```bash
cp git.nix.example git.nix
```

#### 設定ファイルの編集

1. `user.name`を編集

2. SSH接続をする場合は次の箇所のコメントを解除

```
#      url."git@github.com:".insteadOf = "https://github.com/";
#      url."ssh://git@github.com".insteadOf = "https://github.com";
```

#### home.nix の編集

次の箇所のコメントを解除

```
  imports = [
    # git設定ファイル(git.nix)を作成してから次の行のコメントを解除
#    ./git.nix
  ];
```

### 設定の適用

```bash
sudo nixos-rebuild switch --flake .#ホスト名
```

#### 6. 再起動

一度セットアップが成功したあとは次のコマンドでリビルドできます。

```bash
nrsf
```
