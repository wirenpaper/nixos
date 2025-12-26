{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix       # Points to the file in the same folder
    ../../common/configuration.nix     # Points back to the shared common folder

    ../../modules
  ];

  # You can keep this computer-specific if you want, or leave it in common
  networking.hostName = "computer1"; 

  mySetups.present-active.enable = true;
}
