{ pkgs, ... }:

{
    imports = [

    ];

    # 設定ファイルを別置き
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
}
