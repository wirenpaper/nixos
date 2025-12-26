{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix       # Points to the file in the same folder
    ../../common/configuration.nix     # Points back to the shared common folder
    ../../common/profiles/workstation.nix
  ];

  # You can keep this computer-specific if you want, or leave it in common
  networking.hostName = "81WA-x86-64"; 
}
