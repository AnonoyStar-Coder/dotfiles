{ config, pkgs, ... }:

{
  home.username = "balraj";
  home.homeDirectory = "/home/balraj";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.file.".bashrc".source = ./.bashrc;
  
  home.file.".themes".source = ./.themes;

  home.file.".config/qtile".source = ./qtile;

  home.file.".config/kitty".source = ./kitty;

  home.file.".config/alacritty".source = ./alacritty;
  
  home.file.".config/rofi".source = ./rofi;
  
  home.file.".config/spotify-player".source = ./spotify-player;

} 
