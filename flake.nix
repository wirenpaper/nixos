{
  description = "My NixOS Flake Configuration";

  inputs = {
    # This tells the flake where to get the NixOS packages from
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # 'nixos' here must match your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # Assuming you have a standard 64-bit Intel/AMD PC
      system = "x86_64-linux"; 

      specialArgs = { inherit inputs; };

      modules = [
        # This imports your existing configuration.nix file
        ./configuration.nix
      ];
    };
  };
}
