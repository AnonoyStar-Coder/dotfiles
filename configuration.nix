{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # home-manager module now comes from flake.nix
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

  environment.etc."walls/gruvbox-nix.png".source = ./walls/anime1.png;
  environment.etc."walls/castle.jpg".source = ./walls/anime-lock.png;

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
        xwallpaper --zoom /etc/walls/gruvbox-nix.png'';
  };
  services.xserver.displayManager.lightdm = {
      enable = true;
      background = "/etc/walls/castle.jpg";

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
  };

  programs.firefox.enable = true;

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

  services.dbus.enable = true;
  programs.dconf.enable = true;

  programs.xfconf.enable = true;

  hardware.bluetooth.settings = {
	General = {
		Experimental = true;
	};
   };

  services.blueman.enable = true;

  services.picom = {
    enable = true;
    backend = "glx"; # or "xrender"
    vSync = true;
    # Configure opacity for specific applications.
    # Example for Alacritty and Kitty terminals:
    opacity = {
      "80:class_g = 'Alacritty'" = true;
      "80:class_g = 'kitty'" = true;
    };
  };

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
