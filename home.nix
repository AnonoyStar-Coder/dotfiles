{ ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/gtk.nix
    ./modules/configs.nix
  ];

  home.username = "balraj";
  home.homeDirectory = "/home/balraj";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  programs.dconf.enable = true;
}
