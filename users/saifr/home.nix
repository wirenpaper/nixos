{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    slack
    gedit # keep until neovim is stable
    nautilus
    dmenu
    i3lock
    brightnessctl
    pamixer
    networkmanagerapplet
    pnmixer
    adwaita-icon-theme
    hicolor-icon-theme
    pamixer
    pavucontrol
    alsa-utils
    xclip
    tree
    ripgrep

    # THE PYTHON STACK
    (python3.withPackages (ps: with ps; [
      fastapi
      uvicorn
      # 'uno' is provided by LibreOffice. In Nix, we use this 
      # wrapper to ensure the Python env can see the UNO office profile.
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
      "--force-device-scale-factor=1.2" # 1.5 = 150% zoom.
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
          format = "{ %A } %d/%m/%Y %H:%M:%S"; 
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
      cursor-invert-fg-bg = false;
      cursor-color = "cell-foreground";
      cursor-text = "cell-background";
      cursor-style = "block";
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
