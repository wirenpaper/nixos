{ config, pkgs, inputs, ... }:

let 
  qwen-agent = import ./qwen-agent.nix { inherit pkgs; };
in
{
  # THIS MUST BE HERE AT THE TOP LEVEL
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    theme = "~/.config/config-manager/theme.sh";
  };

  programs.gemini-cli = {
    enable = true;
  };

  home.packages = with pkgs; [
    xdotool
    libreoffice-fresh
    gcc
    nodejs
    basedpyright
    xdg-utils
    xwininfo
    slack
    gedit
    nautilus
    dmenu
    i3lock
    brightnessctl
    pamixer
    networkmanagerapplet
    pnmixer
    adwaita-icon-theme
    hicolor-icon-theme
    pavucontrol
    alsa-utils
    xclip
    tree
    ripgrep
    xorg.xlsfonts
    xorg.xset
    xorg.fontmiscmisc
    xhost
    xeyes
    file
    xorg.libXpm
    ghostty

    gnuplot

    sage
    fricas

    gnome-calculator

    texliveFull
    rlwrap
    timg
    imagemagick
    ghostscript
    poppler-utils
    inotify-tools

    # THE PYTHON STACK
    (python3.withPackages (ps: with ps; [
      fastapi
      uvicorn
      sympy
      ollama
      qwen-agent
      pypdf
    ]))
  ];

  # This configures volumeicon to show a slider and use your mixer
  xdg.configFile."volumeicon/volumeicon".text = ''
    [Alsa]
    card=default

    [StatusIcon]
    stepsize=5
    # This makes left-click show the slider
    lmb_slider=true
    # This makes middle-click mute
    mmb_mute=true
    # This opens your pro mixer on right-click
    rclick_command=pavucontrol
  '';

  home.pointerCursor = {
   gtk.enable = true;
   # x11.enable is critical for i3 to see the change
   x11.enable = true;
   package = pkgs.vanilla-dmz;
   name = "Vanilla-DMZ";
   size = 48; # Standard is 16/24. Try 48 or 64 for a big cursor.
  };


  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--force-device-scale-factor=1.2" # 1.2 = 120% zoom.
    ];
  };

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
      #"battery all".enable = false;      # if on laptop
      "battery all" = {
        enable = true;
        position = 9; # 9 puts it right between Volume (8) and Date (10)
        settings = {
          # %status shows charging/discharging, %percentage is the number
          # %remaining shows time left (e.g., 2h 30m)
          format = "%status %percentage %remaining";
          
          # Optional: Customize the status symbols
          status_chr = "⚡ CHR";  # Charging
          status_bat = "🔋 BAT";  # Discharging
          status_unk = "? UNK";   # Unknown
          status_full = "☻ FULL"; # Full
          
          # Alert when battery is low (red color)
          low_threshold = 15;
          threshold_type = "percentage";
        };
      };
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
          format = "{ %A } %d/%m/%Y %H:%M:%S"; 
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = false;
    initContent = builtins.readFile ./extra_zsh_config.zsh;
  };

  programs.neovim = {
    enable = true;

    # This installs the Treesitter plugin AND the python/js parsers correctly compiled for NixOS
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [ 
        p.c 
        p.lua 
        p.python 
        p.javascript 
        p.vim 
        p.vimdoc 
        p.query 
      ]))
    ];

    # key line
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/i3/config".text = builtins.readFile ./i3-config;
  home.file.".config/libreoffice/4/user/registrymodifications.xcu".source = ./registrymodifications.xcu;
}
