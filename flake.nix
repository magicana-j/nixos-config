{
  description = "NixOS + home-manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.nixos-cfsz62 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.amuharai = import ./home.nix;
          backupFileExtension = "backup";
        }
      ];
    };
  };
}
