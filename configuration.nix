{ config, lib, pkgs, ... }:
let
    home-manager=builtins.fetchTarball {
        url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
        sha256 = "0kl0iw1n466h74ijc689a5l9k4wixpx29046cqzdc39wj2ids79f";
    };
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.balraj = import ./home.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
        xwallpaper --zoom ~/walls/snake.png'';
  };
  services.xserver.displayManager.lightdm = {
      enable = true;
      background = "/etc/lightdm/backgrounds/login.png";

      greeters.gtk = {
          enable = true;
          theme.name = "Gruvbox-Dark";
          theme.package = pkgs.gruvbox-gtk-theme;
          iconTheme.name = "Gruvbox-Plus";
          iconTheme.package = pkgs.gruvbox-plus-icons;

          cursorTheme.name = "Future-Cursors";
          cursorTheme.size = 24;

          extraConfig = ''
              font-name = Lilex Nerd Font 12
              xft-antialias = true
              xft-hinting = true
              xft-hintstyle = hintfull
              '';
      };
  };

  nixpkgs.config.allowUnfree = true;

# Enable audio through PipeWire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define your user
  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      neovim
      btop
      ranger
      bluetui
      eza
      librespot
      spotify-player
      oh-my-posh
      rofi
      gh
      spotify
      lazygit
      vscode
      tmux
      twingate
    ];
  };

  programs.firefox.enable = true;

  nix.extraOptions = '' 
        experimental-features = nix-command flakes
      '';

  services.twingate.enable = true;

  virtualisation.docker.enable = true;
        virtualisation.docker.rootless = {
                enable = true;
                setSocketVariable = true;
        };

  # ✅ System-wide Fn key + debug tools + brightness/audio helpers
  boot.kernelModules = [
    "dell-wmi"
    "dell-wmi-sysman"
    "dell-smbios"
    "dell-wmi-descriptor"
    "video"
    "sparse-keymap"
  ];

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };


  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    xwallpaper
    brightnessctl
    pamixer
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-archive-plugin
    xorg.xev
    xorg.xmodmap
    picom
    xbindkeys
    acpi
    libinput
    pavucontrol
    blueman
    bluez
    xcb-util-cursor
    git
    onlyoffice-desktopeditors
    libreoffice
    corefonts
    gruvbox-gtk-theme
    gruvbox-plus-icons
    vista-fonts
    feh
    gvfs
    gnome.gvfs
  ];

  fonts.packages = with pkgs; [
  nerd-fonts.lilex
  nerd-fonts.ubuntu
];

  services.openssh.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.xfconf.enable = true;

  hardware.bluetooth.settings = {
	General = {
		Experimental = true;
	};
   };

  services.blueman.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
