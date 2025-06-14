{ pkgs, ... }:

{
    # Waybar のバイナリ自体は既に extraPackages で入っている。
    # ここでは dotfiles 化と追加フォント・テーマだけを定義。
    #home.packages = with pkgs; [ font-awesome ];

    # XDG_CONFIG_HOME 以下へシンボリックリンク
    xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
    xdg.configFile."waybar/style.css".source    = ./style.css;

    # 例: ログイン時に Waybar が無ければ自動起動（Hyprland 側でも exec-once 済みなら不要）
    systemd.user.services.waybar = {
        Unit = { Description = "Waybar status bar"; };
        Service = {
            ExecStart = "${pkgs.waybar}/bin/waybar";
            Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
    };
}
