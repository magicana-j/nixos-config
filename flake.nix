{
  description = "NixOS + home-manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.hermes = nixpkgs.lib.nixosSystem {
#        specialArgs = {
#          inherit inputs;
#        };
      system = "x86_64-linux";

      modules = [
        ./hosts/hermes/configuration.nix

        home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.amuharai = import ./hosts/hermes/home.nix;
        };
        }

      ];

	  };
  };

}
