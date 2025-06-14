# dotfiles.nix  ― home-manager module
{ config, lib, ... }:

let
  # dotfiles を置いている場所（flaks 内なら相対パスで OK）
  dotfilesDir = ./dotfiles;

  # dotfilesDir 直下の “ディレクトリ” 名だけを抽出
  dirs =
    lib.attrNames
      (lib.filterAttrs (_: t: t == "directory")
        (builtins.readDir dotfilesDir));

  # 生成:  { "<dirName>" = { source = "<absolute path>"; }; }  という attrset
  cfgAttrset = lib.genAttrs dirs (name: {
    # ~/.config/<name> にリンクされる
    source = "${dotfilesDir}/${name}";
    # recursive は false（既定）のまま → ディレクトリごと symlink
  });
in
{
  # ~/.config 以下に張るなら xdg.configFile が最も簡潔
  xdg.configFile = cfgAttrset;
  xdg.enable = true;
  
  # もし ~/.config 以外にも張りたい場合は home.file で同様に作れる
}
