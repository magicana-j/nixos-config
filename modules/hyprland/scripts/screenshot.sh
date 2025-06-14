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

grim $FILENAME

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
