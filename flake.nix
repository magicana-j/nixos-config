{
    description = "NixOS mermaid (GNOME + Hyprland)";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs   = import nixpkgs { inherit system; };
        in {
            nixosConfigurations.mermaid = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    ./modules/system/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;     # soon be depricated
                        home-manager.users.amuharai = ./modules/home/home.nix;
                    }
                ];
            };
        };
}
