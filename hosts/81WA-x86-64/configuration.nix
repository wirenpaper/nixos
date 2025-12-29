{ config, pkgs, ... }:

{
  networking.hostName = "81WA-x86-64"; 
  services.printing.enable = true;

  imports = [
    ./hardware-configuration.nix
    ../../users/saifr/configuration.nix
    ../../modules
  ];

  mySetups.present-active.enable = true;
}
