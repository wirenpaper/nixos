{ config, lib, pkgs, ... }:

{
  # 1. Define the Option (The Switch)
  # This creates a setting called 'mySetups.present-active.enable'
  options.mySetups.present-active.enable = lib.mkEnableOption "Presentation and Office tools";

  # 2. Define the Configuration (What to do when enabled)
  config = lib.mkIf config.mySetups.present-active.enable {
    # We install it at the system level so it's ready as soon as the PC boots
    environment.systemPackages = with pkgs; [
      libreoffice-fresh
    ];
  };
}
