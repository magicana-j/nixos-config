{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "magicana-j";
      user.email = "";
      init.defaultBranch = "main";
      url."git@github.com:".insteadOf = "https://github.com/";
      url."ssh://git@github.com".insteadOf = "https://github.com";
    };
  };

}
