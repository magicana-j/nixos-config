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

  # Neovim
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
set encoding=utf-8
set number
set relativenumber
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set listchars=tab:→\ ,space:·,nbsp:☣,trail:•,eol:¶,precedes:«,extends:»
if &diff
  colorscheme blue
endif
'';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ctrlp ];
      };
    };
  };

  # Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Starship prompt
  programs.starship = {
    enable = true;
  };
}
