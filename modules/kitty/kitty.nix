{ pkgs, ... }:

{
    imports = [

    ];

    # 設定ファイルを別置き
    xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
}
