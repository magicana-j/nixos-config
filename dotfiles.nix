{ config, lib, ... }:

let
  # dotfiles 置き場（絶対パス推奨）
  dot = "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{
  # ── Neovim ───────────────────────────────
  home.file.".config/nvim".source = lib.file.mkOutOfStoreSymlink "${dot}/nvim";

  # ── Waybar ───────────────────────────────
  home.file.".config/waybar".source = lib.file.mkOutOfStoreSymlink "${dot}/waybar";

  # ── kitty の単一ファイル例 ────────────────
  home.file.".config/kitty/kitty.conf".source = lib.file.mkOutOfStoreSymlink "${dot}/kitty/kitty.conf";

  # その他
  home.file.".config/alacritty".source = lib.file.mkOutOfStoreSymlink "${dot}/alacritty";

  home.file.".config/tmux".source = lib.file.mkOutOfStoreSymlink "${dot}/tmux";

  home.file.".config/labwc".source = lib.file.mkOutOfStoreSymlink "${dot}/labwc";

  home.file.".config/niri".source = lib.file.mkOutOfStoreSymlink "${dot}/niri";

}
