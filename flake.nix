{
  description = "NixOS with Home Manager, Git";

  inputs = {
    # ★ バージョン番号を揃えること ★
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      # ===============================================
      # ★ 設定変更はここだけを編集すればOK ★

      vars = {
        release = "25.11";     # ★ バージョン番号を揃えること ★
        system = {
          hostName = "nixos-pc";
          timeZone = "Asia/Tokyo";
          localeJP = "ja_JP.UTF-8";
          localeEN = "en_US.UTF-8";
        };
        user = {
          userName = "yourname";
          shell = "bash";
        };
        git = {
          name = "Change Me";
          email = "yourname@example.dom";
        };
      };

      # ===============================================

    in {
      nixosConfigurations.${vars.system.hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # NixOSモジュールに変数を渡す
        specialArgs = { inherit vars inputs; };
        
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # Home Managerモジュールに変数を渡す
            home-manager.extraSpecialArgs = { inherit vars; };
            home-manager.users.${vars.user.userName} = import ./home.nix;
          }
        ];
      };
    };
}
