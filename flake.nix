{
  description = "Saifr's NixOS Flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    
    nixosConfigurations = {

      # --- ENTRY 1: Your Current Machine ---
      "81WA-x86-64" = nixpkgs.lib.nixosSystem {
        
        # Pass inputs so your modules can access neovim-nightly
        specialArgs = { inherit inputs; };
        
        modules = [
          # 1. The Hardware/Host Config (Drivers, specific modules)
          ./hosts/81WA-x86-64/configuration.nix 

          # 2. The User/System Config (Everything else + Home Manager)
          ./users/saifr/configuration.nix
        ];
      };

      # --- Future machines just look like this: ---
      # "thinkpad" = nixpkgs.lib.nixosSystem {
      #   specialArgs = { inherit inputs; };
      #   modules = [ ./hosts/thinkpad/configuration.nix ./users/saifr/configuration.nix ];
      # };

    };
  };
}
