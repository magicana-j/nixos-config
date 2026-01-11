# NixOS & flakes, home-manager環境構築

- デスクトップ環境：Cinnamon
- 日本語入力ソフトウェア：fcitx5(mozc)

ユーザーディレクトリ名は英語に変更されます。
残った日本語名ディレクトリは削除できます。

## セットアップ手順

### リポジトリをクローン

```bash
cd
nix-shell -p git --run 'git clone https://github.com/yourusername/nixos-config.git'
```

### `setup.sh`を実行

```
cd ~/nixos-config
./setup.sh
```

### `flake.nix`でユーザー名、フルネーム、ホスト名を編集



### `nixos-rebuild`を実行

```
cd ../nixos
sudo nixos-rebuild switch --flake .#
```

### 再起動

一度セットアップが成功した後は以下のエイリアスが使えます。

```bash
nrsf

# sudo nixos-rebuild switch --flake .#ホスト名
```

```bash
nrb

# sudo nixos-rebuild dry-build --flake .#ホスト名
```
