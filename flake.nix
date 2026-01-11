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
      system = "x86_64-linux"; # 必要なら変える

      # NOTE:
      # userName は NixOS インストール時に作成したユーザー名と一致させること
      # 変更すると users.users / home-manager が破綻する
      userName = "amuharai";   # インストール時と同じユーザー名
      fullName = "Change Me";  # 後でここだけ変える
      hostName = "change-me";  # 後でここだけ変える
      commonArgs = { inherit system userName hostName fullName; };
    in {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = commonArgs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = commonArgs;
            home-manager.users.${userName} = import ./home.nix;
          }
        ];
      };
    };

}
