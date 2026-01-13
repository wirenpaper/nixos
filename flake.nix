{
  description = "Saifr's NixOS Flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    sops-nix.url = "github:Mic92/sops-nix";
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
