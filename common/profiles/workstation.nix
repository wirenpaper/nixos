{ config, pkgs, ... }:

{
  imports = [
    ../../modules # This tells the Profile to load the Module Library (default.nix)
  ];

  # This "Profile" defines what a standard workstation looks like for you.
  # It turns on the ingredients you want.
  
  mySetups.present-active.enable = true;
  
  # You can also put settings here that every workstation should have
  # but a server shouldn't (like a PDF viewer or Printing support)
  services.printing.enable = true;
}
