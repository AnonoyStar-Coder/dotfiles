# { config, pkgs, ... }:

# {
#   home.username = "balraj";
#   home.homeDirectory = "/home/balraj";

#   home.stateVersion = "25.05";

#   programs.home-manager.enable = true;
#   fonts.fontconfig.enable = true;

#   home.file.".bashrc".source = ./.bashrc;
  
#   home.file.".themes".source = ./.themes;

#   home.file.".config/qtile".source = ./qtile;

#   home.file.".config/kitty".source = ./kitty;

#   home.file.".config/alacritty".source = ./alacritty;
  
#   home.file.".config/rofi".source = ./rofi;
  
#   home.file.".config/spotify-player".source = ./spotify-player;

# } 

{ config, pkgs, ... }:

{
  home.username = "balraj";
  home.homeDirectory = "/home/balraj";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # Packages
  home.packages = with pkgs; [
  # CLI Tools
  tree neovim btop ranger eza tmux

  # Bluetooth & Music
  bluetui librespot spotify-player spotify

  # Dev Stuff
  gh lazygit vscode nodejs

  # Fancy Shell Vibes
  oh-my-posh rofi

  # Remote Access
  twingate
];

  # 🧠 Shell & theming
  home.file.".bashrc".source = ./.bashrc;
  home.file.".bash-alias".source = ./.bash-alias;
  home.file.".theme.omp.json".source = ./.theme.omp.json;
  home.file.".themes".source = ./.themes;

  # 🧩 Config directories
  home.file.".config/qtile".source = ./qtile;
  home.file.".config/kitty".source = ./kitty;
  home.file.".config/alacritty".source = ./alacritty;
  home.file.".config/rofi".source = ./rofi;
  home.file.".config/spotify-player".source = ./spotify-player;

  # 🎨 Wallpapers (if user also accesses them)
  home.file.".config/walls".source = ./walls;
}
