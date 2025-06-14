{ pkgs, ... }:

{
    imports = [

    ];

    # 設定ファイルを別置き
    xdg.configFile."nvim/init.lua".source = ./init.lua;
}
