{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme.override {
        tweaks = [ "dark" ];  # select the 'Dark' variant
      };
      name = "Orchis-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
}