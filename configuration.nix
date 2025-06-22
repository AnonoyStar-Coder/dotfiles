{ config, lib, pkgs, ... }:
let
    home-manager=builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
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
        xwallpaper --zoom ~/walls/castle.jpg
        '';
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
    alacritty
    xwallpaper
    brightnessctl
    pamixer
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-archive-plugin
    xorg.xev
    xorg.xmodmap
    xbindkeys
    acpi
    libinput
    pavucontrol
    blueman
    bluez
    xcb-util-cursor
    git
  ];

  fonts.packages = with pkgs; [
  nerd-fonts.lilex
  nerd-fonts.ubuntu
];

  services.openssh.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.settings = {
	General = {
		Experimental = true;
	};
   };

  services.blueman.enable = true;

  system.stateVersion = "25.05";
}
