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
    userConfigPath = 
      if builtins.pathExists ./user-config.nix
      then ./user-config.nix
      else ./user-config.example;
      
    userConfig = import userConfigPath;
    
    inherit (userConfig) system username hostname gpuType;
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit username hostname gpuType;
        inherit userConfig;
      };
      
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home.nix;
            extraSpecialArgs = {
              inherit username userConfig;
            };
          };
        }

      ];

	  };
  };

}
