{ config, lib, pkgs, inputs, ... }: # 'inputs' is available thanks to specialArgs

let
  # This grabs the unstable package set for your specific architecture (x86_64-linux)
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.mySetups.ollama.enable = lib.mkEnableOption "Ollama local AI service";

  config = lib.mkIf config.mySetups.ollama.enable {
    services.ollama = {
      enable = true;
      # Force the service to use the unstable (v0.5.0+) version
      package = unstable.ollama; 
      acceleration = null; # Pentium CPU focus
    };

    # Update the CLI tool so 'ollama pull' works with new manifests
    environment.systemPackages = [
      unstable.ollama
    ];
  };
}
