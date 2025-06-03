# 日本語環境セットアップガイド

## 🇯🇵 含まれるコンポーネント

### 日本語入力
- **Fcitx5**: 次世代入力メソッドフレームワーク
- **Mozc**: Google日本語入力のオープンソース版
- **Fcitx5-GTK**: GTKアプリケーション対応

### フォント
- **Noto Sans CJK**: Google製の美しい日本語サンセリフフォント
- **Noto Serif CJK**: Google製の日本語セリフフォント
- **Source Code Pro**: Adobe製のプログラミング向けフォント
- **Noto Emoji**: 絵文字フォント

## 🚀 セットアップ手順

### 1. Home Manager設定の適用
```bash
cd ~/nixos-config
home-manager switch --flake .#your-username
```

### 2. Fcitx5設定ファイルの作成
上記のFcitx5設定ファイルを`dotfiles/fcitx5/`に作成してください。

### 3. システム再起動
```bash
sudo reboot
```

### 4. Fcitx5の起動
```bash
# 自動起動されない場合は手動起動
fcitx5 &

# 設定ツールを起動
fcitx5-configtool
```

## ⚙️ 設定方法

### Fcitx5設定ツールでの設定

1. **入力メソッドの追加**:
   - `fcitx5-configtool`を起動
   - 「Input Method」タブで「+」をクリック
   - 「Only Show Current Language」のチェックを外す
   - 「Mozc」を検索して追加

2. **キーバインドの設定**:
   - 「Global Options」タブ
   - 「Trigger Input Method」: `Ctrl+Space` または `Zenkaku_Hankaku`
   - 「Enumerate Input Method Forward」: `Super+Space`（任意）

3. **Mozcの詳細設定**:
   - 「Input Method」タブでMozcを選択
   - 「Configure」をクリック
   - 好みに応じて設定を調整

### 手動設定（コマンドライン）

```bash
# Fcitx5の状態確認
fcitx5-diagnose

# 利用可能な入力メソッド確認
fcitx5-remote -s

# 入力メソッドの切り替え
fcitx5-remote -t
```

## 🔧 トラブルシューティング

### 入力メソッドが動作しない場合

1. **環境変数の確認**:
```bash
echo $GTK_IM_MODULE
echo $QT_IM_MODULE
echo $XMODIFIERS
```

2. **Fcitx5プロセスの確認**:
```bash
ps aux | grep fcitx5
```

3. **再起動**:
```bash
pkill fcitx5
fcitx5 &
```

### アプリケーション固有の問題

#### VS Code
```json
// settings.jsonに追加
{
  "terminal.integrated.env.linux": {
    "GTK_IM_MODULE": "fcitx",
    "QT_IM_MODULE": "fcitx",
    "XMODIFIERS": "@im=fcitx"
  }
}
```

#### Firefox
- `about:config`で`gtk.ime.enabled`を`true`に設定

#### Terminal
```bash
# .bashrc または .zshrc に追加
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

## 🎨 フォント設定

### システムフォントの確認
```bash
# インストールされているフォント一覧
fc-list | grep -i noto
fc-list | grep -i "source code"

# フォントの詳細情報
fc-list : family | grep -i noto
```

### アプリケーション固有のフォント設定

#### VS Code
```json
{
  "editor.fontFamily": "'Source Code Pro', 'Noto Sans CJK JP', monospace",
  "editor.fontSize": 14
}
```

#### Terminal
```bash
# Cinnamonの端末設定で以下を設定
# フォント: Source Code Pro 12
# 日本語フォント: Noto Sans CJK JP
```

## 📝 カスタマイズ例

### Mozcの辞書カスタマイズ
```bash
# ユーザー辞書の編集
/usr/lib/mozc/mozc_tool --mode=dictionary_tool
```

### Fcitx5のテーマ変更
```bash
# テーマの確認
ls ~/.local/share/fcitx5/themes/
ls /usr/share/fcitx5/themes/

# カスタムテーマの適用
# fcitx5-configtoolの「Appearance」タブで設定
```

## ✅ 動作確認チェックリスト

- [ ] Ctrl+Spaceでの入力メソッド切り替え
- [ ] ひらがな入力と変換動作
- [ ] 各アプリケーションでの日本語入力
  - [ ] Firefox
  - [ ] VS Code
  - [ ] Terminal
  - [ ] テキストエディタ
- [ ] フォントの正しい表示
- [ ] 絵文字の表示

これで、NixOS環境で快適な日本語入力が可能になります！
