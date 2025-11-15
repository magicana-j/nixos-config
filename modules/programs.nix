{ config, pkgs, ... }:

{
  # Program configurations

  # Firefox
  programs.firefox.enable = true;

  # Nano text editor
  programs.nano.nanorc = ''
    set softwrap
    set linenumbers
    set autoindent
    set tabtospaces
    set tabsize 2
  '';

  };

  # Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
