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

      "saif-lenovo" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        
        modules = [
          ./hosts/saif-lenovo/configuration.nix 
          ./users/saifr/configuration.nix
        ];
      };

      "saif-thinkpad" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        
        modules = [
          ./hosts/saif-thinkpad/configuration.nix 
          ./users/saifr/configuration.nix
        ];
      };

    };
  };
}
