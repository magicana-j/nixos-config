{
  description = "NixOS + flakes + home-manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    userConfigExists = builtins.pathExists (self.outPath + "/user-config.nix");

    userConfig =
      if userConfigExists
      then import ./user-config.nix
      else throw ''

        ========================================
        エラー: user-config.nix が見つかりません
        ========================================

        初回セットアップ手順:

        1. 現在のユーザー名を確認:
            whoami

        2. setup.sh を実行:
            cd ${self.outPath}
            ./setup.sh

            重要: username は現在ログインしているユーザー名と
                  完全に一致させてください!

        4. 再度ビルドを実行

        ========================================
      '';

    inherit (userConfig) system myName myHostname;
  in {
    nixosConfigurations.${myHostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit myName myHostname;
        inherit userConfig;
      };

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.${myName} = import ./home.nix;
            extraSpecialArgs = {
              inherit myName userConfig;
            };
          };
        }

      ];

	  };
  };

}
