{ config, pkgs, ... }:

{
  networking.hostName = "saif-thinkpad"; 
  services.printing.enable = true;

  imports = [
    ./hardware-configuration.nix
    ../../users/saifr/configuration.nix
    ../../modules
  ];

}
