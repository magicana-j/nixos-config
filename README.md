# NixOS Configuration

## セットアップ手順

### クイックスタート（サンプル設定で試す場合）

リポジトリをクローンして、すぐに試すことができます：
```bash
git clone https://github.com/yourusername/nixos-config.git ~/
cd ~/nixos-config
```

```bash
./install.sh
cd ../nixos
```

```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
sudo nixos-rebuild switch --flake .#mynixos
```

**注意**: この方法では`user-config.nix.example`のデフォルト値が使用されます。
本番環境では必ず以下の「本番環境のセットアップ」を実行してください。

### 本番環境のセットアップ

#### 1. リポジトリのクローン
```bash
git clone https://github.com/yourusername/nixos-config.git /etc/nixos
cd /etc/nixos
```

#### 2. ユーザー設定ファイルの作成
```bash
cp user-config.nix.example user-config.nix
cp git.nix.example git.nix
```

#### 3. 設定ファイルの編集

`user-config.nix`を編集して、自分の環境に合わせて設定します：
```bash
nano user-config.nix

nano git.nix
```

必須の設定項目：
- `myName`: ユーザー名
- `myHostname`: ホスト名
- `gpuType`: GPUの種類（"intel" または "amd"）
- `userFullName`: フルネーム（Gitなどで使用）
- `userEmail`: メールアドレス

#### 4. ハードウェア設定の生成
```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

#### 5. 設定の適用
```bash
# user-config.nixで設定したホスト名を使用
sudo nixos-rebuild switch --flake .#あなたのホスト名

# または、サンプル設定のデフォルトホスト名(mynixos)を使用する場合
sudo nixos-rebuild switch --flake .#mynixos

# 一度セットアップが成功したあとは次のコマンドでリビルドできます。
nsrf
```

## 設定ファイルについて

### 自動フォールバック機能

`user-config.nix`が存在しない場合、システムは自動的に`user-config.nix.example`を読み込みます。
ただし、デフォルト値が使用されるため、ビルド時に警告メッセージが表示されます。

### 推奨される運用方法

1. **初回テスト**: サンプル設定でシステムが動作することを確認
2. **カスタマイズ**: `user-config.nix`を作成して自分の環境に合わせる
3. **本番運用**: カスタマイズした設定で運用

## GPU設定の変更

~~`user-config.nix`の`gpuType`を変更して、再度適用してください：~~

現在AMD-GPUの設定によるビルド結果は未確認です。

```nix
gpuType = "amd";  # Intel から AMD に変更する場合
```

## ファイル管理

Git管理されないファイル：
- `user-config.nix` - 個人設定（各自で作成）
-  git.nix 個人のgit設定（各自で作成）
- `hardware-configuration.nix` - ハードウェア固有設定（各自で生成）

Git管理されるファイル：
- `user-config.nix.example` - サンプル設定
- その他の設定ファイル
