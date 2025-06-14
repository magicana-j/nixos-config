{ config, lib, ... }:

let
  # dotfiles 置き場（絶対パス推奨）
  dot = "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{
  # ── Neovim ───────────────────────────────
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dot}/nvim";

  # ── Waybar ───────────────────────────────
  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${dot}/waybar";

  # ── kitty の単一ファイル例 ────────────────
  home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${dot}/kitty/kitty.conf";

  # その他
  home.file.".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${dot}/alacritty";

  home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${dot}/tmux";

  home.file.".config/labwc".source = config.lib.file.mkOutOfStoreSymlink "${dot}/labwc";

  home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${dot}/niri";

}
