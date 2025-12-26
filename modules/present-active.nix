{ config, lib, pkgs, ... }:

{
  # 1. Define the Option (The Switch)
  # This creates a setting called 'mySetups.present-active.enable'
  options.mySetups.present-active.enable = lib.mkEnableOption "Presentation Active Setup";

  # 2. Define the Configuration (What to do when enabled)
  config = lib.mkIf config.mySetups.present-active.enable {
    # We install it at the system level so it's ready as soon as the PC boots
    environment.systemPackages = with pkgs; [
      libreoffice-fresh
    ];
    # We define the path once here as a local variable inside the config block
    environment.variables =
      let
        # This finds the actual folder where uno.py and pyuno.so live
        # We use pkgs.libreoffice-fresh directly
        officePath = "${pkgs.libreoffice-fresh}/lib/libreoffice/program";
      in {
        # 1. Tells Python where to find uno.py
        PYTHONPATH = [ "${officePath}" ];

        # 2. The critical "Soul" of the Office bridge
        URE_BOOTSTRAP = "vnd.sun.star.pathname:${officePath}/fundamentalrc";

        # 3. Tells the system where the C++ 'muscles' (shared libraries) are
        LD_LIBRARY_PATH = [ "${officePath}" ];
      };
  };
}
