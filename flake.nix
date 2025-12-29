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
    
    # THE PHONEBOOK
    nixosConfigurations = {

      # --- ENTRY 1: Your Current Machine ---
      "81WA-x86-64" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        
        modules = [
          # Hardcoded path to match the current folder structure
          ./hosts/81WA-x86-64/configuration.nix 

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            
            home-manager.users.saifr = import ./users/saifr/home.nix;
          }
        ];
      };

      # --- ENTRY 2: Future machines can be added here ---
      # "thinkpad" = ...

    };
  };
}
