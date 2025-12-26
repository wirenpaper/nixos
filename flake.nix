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

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      # --- THE ONLY PLACE YOU EVER CHANGE THE NAME ---
      host = "81WA-x86-64";
      # -----------------------------------------------
    in {
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          # This automatically points to ./hosts/81WA_x86_64/configuration.nix
          ./hosts/${host}/configuration.nix 

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            
            home-manager.users.saifr = import ./common/home.nix;
          }
        ];
      };
    };
}
