{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    google-chrome
    gedit
    nautilus
    libreoffice-fresh
    # st is gone!
  ];

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
}
