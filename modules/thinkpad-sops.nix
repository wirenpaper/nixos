{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.mySetups.thinkpad-sops;
in
{
  options.mySetups.thinkpad-sops.enable = lib.mkEnableOption "Thinkpad Gemini SOPS setup";

  config = lib.mkIf cfg.enable {
    home-manager.users.saifr = { config, ... }: {
      
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      sops = {
        defaultSopsFile = ../secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "/home/saifr/.config/sops/age/keys.txt"; 

        secrets.gemini_key_thinkpad_goldenage = {};
        secrets.gemini_key_thinkpad_chumchumchira = {};
      };

      home.sessionVariables = {
        # Environmental keys
        KEY1 = "$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.gemini_key_thinkpad_goldenage.path})";
        KEY2 = "$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.gemini_key_thinkpad_chumchumchira.path})";
        GEMINI_API_KEY = "$KEY1";
      };

      # Shell-agnostic aliases
      home.shellAliases = {
        gemini  = "GEMINI_API_KEY=$KEY1 ${pkgs.gemini-cli}/bin/gemini --model gemini-3-flash-preview -r latest";
        gemini2 = "GEMINI_API_KEY=$KEY2 ${pkgs.gemini-cli}/bin/gemini --model gemini-3-flash-preview -r latest";
      };
    };
  };
}
