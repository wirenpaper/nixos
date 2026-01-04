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

    #pix2tex-src = { url = "github:lukas-blecher/LaTeX-OCR"; flake = false; };

    # PIN TO 0.25.4 - This is the "Era-Correct" version for pix2tex 0.1.4
    #x-transformers-src = { url = "github:lucidrains/x-transformers/0.25.4"; flake = false; };
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
