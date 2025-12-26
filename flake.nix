{
  description = "Saifr's NixOS Flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Add Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add this: The nightly Neovim source
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.computer1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # 1. Point to the host-specific configuration
        ./hosts/computer1/configuration.nix 

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          # 2. Point to the shared home settings
          home-manager.users.saifr = import ./common/home.nix;
        }
      ];
    };
  };
}
