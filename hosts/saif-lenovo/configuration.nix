{ config, pkgs, ... }:

{
  networking.hostName = "saif-lenovo"; 
  services.printing.enable = true;

  imports = [
    ./hardware-configuration.nix
    ../../users/saifr/configuration.nix
    ../../modules
  ];

  mySetups.present-active.enable = true;
  mySetups.ollama.enable = true;
}
