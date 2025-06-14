#!/bin/bash

# 保存先ディレクトリ
SAVE_DIR="$HOME/Screenshots"

# 保存先ディレクトリが存在しない場合は作成
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
    if [ $? -ne 0 ]; then
        dunstify "Screenshot" "Failed to create directory: $SAVE_DIR" -u critical
        exit 1
    fi
fi


# タイムスタンプでファイル名を生成
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="${SAVE_DIR}/screenshot_${TIMESTAMP}.png"

# スクリーンショットの種類
MODE="$1" # 'region', 'full', 'window'

case "$MODE" in
    region)
        # 領域選択
        SELECTED_GEOMETRY=$(slurp)
        if [ -z "$SELECTED_GEOMETRY" ]; then
            exit 1 # 選択をキャンセルした場合
        fi
        grim -g "$SELECTED_GEOMETRY" "$FILENAME"
        ;;
    full)
        # 全画面
        grim "$FILENAME"
        ;;
    window)
        # アクティブウィンドウ (grimは直接ウィンドウ選択をサポートしないため、grimshotなどのラッパーを使うか、手動でウィンドウ情報を取得する必要がある)
        # または、grimshotなどのツールを使うのが簡単
        # この例では、grim + slurp の組み合わせを強調するため、grim単体でのウィンドウ取得は割愛します。
        # 代替として、grimshotのようなツールを検討してください。
        # 例：grimshot save active "$FILENAME"
        # あるいは、手動でgrimにウィンドウの座標を渡す（複雑になる）
        grim "$FILENAME" # とりあえず全画面を撮るか、手動で座標を指定
        ;;
    *)
        echo "Usage: $0 [region|full|window]"
        exit 1
        ;;
esac

# スクリーンショットが成功したか確認
if [ -f "$FILENAME" ]; then
    # クリップボードにコピー
    wl-copy < "$FILENAME"

    # 通知を表示 (dunstが実行されていることを前提)
    dunstify "Screenshot" "Saved to $FILENAME and copied to clipboard." -i "$FILENAME" -t 3000

    echo "Screenshot saved: $FILENAME"
else
    dunstify "Screenshot" "Failed to take screenshot." -u critical
    echo "Failed to take screenshot."
fi
