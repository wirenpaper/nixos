{ config, lib, pkgs, ... }:

{
  options.mySetups.present-active.enable = lib.mkEnableOption "Present Active Setup";

  config = lib.mkIf config.mySetups.present-active.enable {
    # --- HARDCODED NETWORK REALITY ---
    #networking.interfaces.wlp0s20f3.ipv4.addresses = [{
    networking.interfaces.wlan0.ipv4.addresses = [{
      address = "192.168.100.7";
      prefixLength = 24;
    }];

    #networking.defaultGateway = "192.168.100.1";
    networking.defaultGateway = {
      address = "192.168.100.1";
      interface = "wlan0";
    };
    networking.nameservers = [ "1.1.1.1" ];

    programs.java.enable = true;

    environment.systemPackages = with pkgs; [
      libreoffice-fresh
    ];

    environment.variables = 
      let 
        # WE USE THE UNWRAPPED PACKAGE FOR THE PATHS
        officePath = "${pkgs.libreoffice-fresh.unwrapped}/lib/libreoffice/program";
      in {
        PYTHONPATH = [ "${officePath}" ];
        # This is the "Soul" - it must point to the REAL file in the unwrapped store
        URE_BOOTSTRAP = "vnd.sun.star.pathname:${officePath}/fundamentalrc";
        LD_LIBRARY_PATH = [ "${officePath}" ];
      };

    networking.firewall.allowedTCPPorts = [ 8000 2002 ];
  };
}
