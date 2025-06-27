{ pkgs, ... }:

{
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

    # Declarative Theme
    gruvbox-gtk-theme
    gruvbox-plus-icons
  ];
}
