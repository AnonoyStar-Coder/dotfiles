{ config, pkgs, ... }:

{
  home.username = "balraj";
  home.homeDirectory = "/home/balraj";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.file.".bashrc".source = /home/balraj/dotfiles/.bashrc;
  
  home.file.".themes".source = /home/balraj/dotfiles/.themes;

  home.file.".config/qtile".source = /home/balraj/dotfiles/qtile;

  home.file.".config/kitty".source = /home/balraj/dotfiles/kitty;

  home.file.".config/alacritty".source = /home/balraj/dotfiles/alacritty;
  
  home.file.".config/rofi".source = /home/balraj/dotfiles/rofi;
  
  home.file.".config/spotify-player".source = /home/balraj/dotfiles/spotify-player;

} 
