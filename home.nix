{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    google-chrome
    gedit
    nautilus
    libreoffice-fresh
    dmenu
    i3lock
    pamixer
    networkmanagerapplet
    volctl
    xclip
  ];

  # 2. Add the i3status configuration module
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 5;
    };
    # This defines the modules and their order
    modules = {
      "ipv6".enable = false;
      "wireless _first_".enable = false; # Set to true if you use Wi-Fi
      "battery all".enable = false;      # Set to true if on a laptop
      "disk /".settings.format = "%avail";
      "load".settings.format = "%1min";
      "memory".settings.format = "%used | %available";
      
      # VOLUME PART
      "volume master" = {
        position = 8; 
        settings = {
          format = "♪: %volume";
          format_muted = "♪: muted (%volume)";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };
      
      # THE DATE PART
      "tztime local" = {
        position = 10; # Usually at the end
        settings = {
          # %d = Day, %A = Weekday, %m = Month, %Y = Year
          format = "%d{%A}/%m/%Y %H:%M:%S"; 
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ./extra_zsh_config.zsh;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "PxPlus IBM VGA 8x16";
      font-size = 22;
      window-decoration = false;
    };
  };
  
  # THIS IS THE NIX WAY for a whole folder
  xdg.configFile."nvim" = {
    source = ./nvim-config;
    recursive = true; # Ensures subfolders like /lua or /after are handled
  };

  programs.neovim = {
    enable = true;

    # key line
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/i3/config".text = builtins.readFile ./i3-config;
}
