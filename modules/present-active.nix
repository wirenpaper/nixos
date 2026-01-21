{ config, lib, pkgs, ... }:

{
  options.mySetups.present-active.enable = lib.mkEnableOption "Present Active Setup";

  config = lib.mkIf config.mySetups.present-active.enable {
    networking.interfaces.wlan0.ipv4.addresses = [{
      address = "192.168.100.7";
      prefixLength = 24;
    }];

    programs.zsh.shellAliases = {
      slides = "python ~/rnd/slides_server/ignition.py";
    };

    networking.defaultGateway = {
      address = "192.168.100.1";
      interface = "wlan0";
    };
    networking.nameservers = [ "1.1.1.1" ];

    #environment.systemPackages = with pkgs; [
    #  libreoffice-fresh
    #];

    environment.variables = 
      let 
        # WE USE THE UNWRAPPED PACKAGE FOR THE PATHS
        officePath = "${pkgs.libreoffice-fresh.unwrapped}/lib/libreoffice/program";
      in {
        PYTHONPATH = [ "${officePath}" ];
        URE_BOOTSTRAP = "vnd.sun.star.pathname:${officePath}/fundamentalrc";
        LD_LIBRARY_PATH = [ "${officePath}" ];
      };

    networking.firewall.allowedTCPPorts = [ 8000 2002 ];
  };
}
