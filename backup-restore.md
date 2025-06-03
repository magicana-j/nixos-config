# NixOS バックアップ・復元チェックリスト

## 📤 クリーンインストール前のバックアップ

### 🔧 設定ファイル（必須）
- [ ] `~/nixos-config/` 全体をGitにプッシュ
- [ ] `/etc/nixos/configuration.nix` を確認・バックアップ
- [ ] `/etc/nixos/hardware-configuration.nix` （参考用）

### 🔑 認証・セキュリティ
- [ ] SSH鍵: `~/.ssh/` 
- [ ] GPG鍵: `gpg --export-secret-keys > private.key`
- [ ] Git設定: `~/.gitconfig`

### 📁 個人データ
- [ ] `~/Documents/`
- [ ] `~/Pictures/`
- [ ] `~/Downloads/` （重要ファイルのみ）
- [ ] プロジェクトフォルダ: `~/projects/`, `~/work/` など

### 🌐 ブラウザ設定
- [ ] Firefox: `~/.mozilla/firefox/`
- [ ] Chrome: `~/.config/google-chrome/` (使用している場合)

### 📝 アプリケーション設定（NixOS管理外）
- [ ] VS Code Extensions リスト: `code --list-extensions > extensions.txt`
- [ ] OBS Studio設定: `~/.config/obs-studio/`
- [ ] その他手動設定したアプリの設定

## 📥 復元後のチェック項目

### ✅ システム基本機能
- [ ] ネットワーク接続
- [ ] 音声出力・入力
- [ ] ディスプレイ設定
- [ ] 言語・キーボード設定

### ✅ NixOS設定
- [ ] lyディスプレイマネージャ起動
- [ ] Cinnamonデスクトップ起動
- [ ] 全パッケージがインストール済み
- [ ] dotfiles設定が適用済み

### ✅ 開発環境
- [ ] Git設定復元: `git config --list`
- [ ] SSH接続テスト: `ssh -T git@github.com`
- [ ] Neovim設定動作確認
- [ ] VS Code起動・拡張機能復元

### ✅ メディア・その他
- [ ] OBS Studio起動・設定確認
- [ ] Firefox起動・ブックマーク確認
- [ ] 日本語入力設定（必要に応じて）

## 🚀 効率的な復元手順

### 手順1: 最小システム準備
```bash
# 基本的なNixOSインストール完了後
sudo nano /etc/nixos/configuration.nix
# → Flakes有効化 + git追加
sudo nixos-rebuild switch
```

### 手順2: 自動復元実行
```bash
# 復元用スクリプトを実行
curl -L https://raw.githubusercontent.com/yourusername/nixos-config/main/restore.sh | bash
# または
wget https://github.com/yourusername/nixos-config/raw/main/restore.sh
chmod +x restore.sh
./restore.sh
```

### 手順3: 個人データ復元
```bash
# バックアップから個人データを復元
rsync -av backup/Documents/ ~/Documents/
rsync -av backup/.ssh/ ~/.ssh/
chmod 600 ~/.ssh/id_*
```

## 📋 復元スクリプトのカスタマイズ

### restore.shの編集ポイント
1. **REPO_URL**: 自分のGitHubリポジトリURL
2. **USERNAME**: ユーザー名（自動取得されるが、固定も可能）
3. **追加パッケージチェック**: apps_to_check配列にアプリ追加

### システム固有の調整
```bash
# restore.sh実行後に必要に応じて実行
# ハードウェア設定の微調整
sudo nano /etc/nixos/configuration.nix

# ネットワーク設定
sudo systemctl restart NetworkManager

# 音声設定
pavucontrol  # 必要に応じて
```

## 🔄 定期的なメンテナンス

### 月次チェック
- [ ] 設定変更をGitコミット・プッシュ
- [ ] バックアップ対象の見直し
- [ ] restore.shの動作テスト

### 重要変更時
- [ ] 大きな設定変更前にスナップショット
- [ ] 新アプリ追加時のチェックリスト更新
- [ ] ハードウェア変更時の設定調整

これにより、NixOSの設定管理とクリーンインストールからの復元が確実に行えます。
