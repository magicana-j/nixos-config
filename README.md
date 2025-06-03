# NixOS クリーンインストール後の復元手順

## 🚀 前提条件
- ユーザー名とホスト名は以前と同じ
- GitHubなどにnixos-configをプッシュ済み
- 基本的なNixOS 25.05がインストール済み

## 📋 復元手順

### Step 1: 基本システム設定

#### 1.1 Flakesを有効化
```bash
# /etc/nixos/configuration.nixを編集
sudo nano /etc/nixos/configuration.nix
```

以下を追加：
```nix
{
  # Flakes有効化
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # 必要最小限のパッケージ
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];
}
```

```bash
# システム再構築
sudo nixos-rebuild switch
```

### Step 2: 設定リポジトリの取得

#### 2.1 Gitリポジトリクローン
```bash
# ホームディレクトリに移動
cd ~

# 設定リポジトリをクローン
git clone https://github.com/yourusername/nixos-config.git

# ディレクトリに移動
cd nixos-config
```

#### 2.2 設定ファイルの確認・調整
```bash
# ユーザー名・ホスト名が正しいか確認
grep -r "your-username" .
grep -r "your-hostname" .

# 必要に応じて編集（同じなら不要）
# nano flake.nix
# nano home.nix
```

### Step 3: システムレベル設定の復元

#### 3.1 システム設定をFlakesで管理している場合
```bash
# システム設定にflake.nixがある場合
sudo cp flake.nix /etc/nixos/
sudo cp system.nix /etc/nixos/ # システム設定ファイルがある場合

# システム再構築
sudo nixos-rebuild switch --flake /etc/nixos#your-hostname
```

#### 3.2 従来方式の場合
```bash
# configuration.nixを手動で設定
sudo nano /etc/nixos/configuration.nix
```

### Step 4: Home Manager設定の復元

#### 4.1 Home Managerの初回実行
```bash
cd ~/nixos-config

# 依存関係の確認
nix flake check

# Home Manager適用
nix run home-manager/release-25.05 -- switch --flake .#your-username
```

#### 4.2 エラーが発生した場合
```bash
# キャッシュクリア
nix-collect-garbage -d

# flake.lockを再生成
rm flake.lock
nix flake update

# 再実行
home-manager switch --flake .#your-username
```

### Step 5: システム全体の設定適用

#### 5.1 最終システム更新
```bash
# システム更新
sudo nixos-rebuild switch --upgrade

# 再起動
sudo reboot
```

#### 5.2 動作確認
```bash
# インストールされたパッケージ確認
home-manager packages

# dotfiles確認
ls -la ~/.config/nvim/
ls -la ~/.config/Code/User/

# アプリケーション起動テスト
nvim --version
code --version
obs --version
```

## 🔧 システム固有設定の調整

### ハードウェア設定
```bash
# 新しいhardware-configuration.nixが生成されているか確認
ls -la /etc/nixos/hardware-configuration.nix

# 必要に応じてシステム設定に統合
```

### ネットワーク設定
```bash
# ネットワーク名の確認・調整
ip addr show

# 必要に応じてconfiguration.nixで設定
```

## 📦 追加の復元作業

### ブラウザ設定・データ
```bash
# Firefoxプロファイルの手動復元（必要に応じて）
# ~/.mozilla/firefox/のバックアップがある場合
```

### SSH鍵・GPG鍵の復元
```bash
# SSH鍵復元
cp backup/.ssh/* ~/.ssh/
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub

# GPG鍵復元（バックアップがある場合）
gpg --import backup/private.key
```

### データディレクトリの復元
```bash
# ユーザーデータの復元
# Documents, Pictures, Downloads等のバックアップがある場合
```

## 🚨 トラブルシューティング

### よくある問題と対処法

#### Home Manager適用エラー
```bash
# 権限問題
sudo chown -R $USER:$USER ~/.config

# 競合するファイル
rm -rf ~/.config/conflicting-app
home-manager switch --flake .#your-username
```

#### パッケージ不整合
```bash
# キャッシュ完全クリア
sudo nix-collect-garbage -d
nix-collect-garbage -d

# チャンネル更新
sudo nix-channel --update
```

#### 設定ファイル競合
```bash
# 既存設定のバックアップ
mv ~/.config/app ~/.config/app.backup

# Home Manager再適用
home-manager switch --flake .#your-username
```

## ✅ 復元完了チェックリスト

- [ ] システムが正常起動する
- [ ] lyディスプレイマネージャが動作
- [ ] Cinnamonデスクトップが起動
- [ ] 全アプリケーション（neovim, vscode, obs-studio）が起動
- [ ] dotfiles設定が正しく適用
- [ ] Git設定が復元されている
- [ ] ネットワーク接続が正常
- [ ] 日本語入力が動作（必要に応じて）

## 🔄 今後の改善点

### 自動化スクリプトの作成
```bash
# restore.sh として保存
#!/bin/bash
set -e

echo "NixOS configuration restore starting..."
cd ~/nixos-config
nix flake update
home-manager switch --flake .#$(whoami)
sudo nixos-rebuild switch --upgrade
echo "Restore completed!"
```

これで、クリーンインストール後でも設定を素早く復元できます。
