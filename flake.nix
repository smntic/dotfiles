{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cp-tool.url = "path:/home/simon/git/cp-tool/"; # "github:smntic/cp-tool";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.x13 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        # Flake modules
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager 

        # System configuration modules
        ./config/configuration.nix
        ./config/hardware-configuration.nix

        # Home manager configuration
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.simon = {
              imports = [
                ./home/home.nix
              ];
            };
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
