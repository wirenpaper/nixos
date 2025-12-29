{ config, pkgs, ... }:

{
  networking.hostName = "81WA-x86-64"; 
  services.printing.enable = true;

  imports = [
    ./hardware-configuration.nix       # Points to the file in the same folder
    ../../common/configuration.nix     # Points back to the shared common folder
    ../../modules
  ];

  mySetups.present-active.enable = true;
}
