{ pkgs, ... }:

{
    imports = [

    ];

    # 設定ファイルを別置き
    xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
}
