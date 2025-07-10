{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  ##########################
  ## System Configuration ##
  ##########################

  networking.hostName = lib.mkDefault "nixos"; # hostname por defecto
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  ##################
  ## Nix Settings ##
  ##################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  ########################
  ## Boot Configuration ##
  ########################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ##########################
  ## NVIDIA Configuration ##
  ##########################

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = lib.mkDefault false;
    powerManagement.finegrained = lib.mkDefault false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  #######################
  ## Networking & Time ##
  #######################

  networking.networkmanager.enable = true;
  time.timeZone = "America/Santiago";

  ##################
  ## Localization ##
  ##################

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };
  
  ###########################
  ## X11 & Display Manager ##
  ###########################

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us, latam";
    variant = "";
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  ####################
  ## Window Manager ##
  ####################

  programs.hyprland.enable = true;

  ###########
  ## Audio ##
  ###########

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  ##############
  ## Programs ##
  ##############

  programs.zsh.enable = true;
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  
  # Theme and appearance
  programs.dconf.enable = true;
  services.dbus.enable = true;
  
  # XDG Desktop Portal for proper theming
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
  
  # Ensure icon paths are available system-wide
  environment.pathsToLink = [ "/share/icons" ];
  
  # Environment variables for dark mode
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum-dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  ########################
  ## User Configuration ##
  ########################

  users.users.nyx = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Pablo Cruzval";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ##################
  ## Home Manager ##
  ##################

  home-manager = lib.mkDefault {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "nyx" = import ../profiles/base.nix;
    };
  };

  #####################
  ## System Packages ##
  #####################

  environment.systemPackages = with pkgs; [
    gcc
    git
    vim
    wget
    killall
    nvidia-vaapi-driver
    libva-utils
    vulkan-tools
    glxinfo
    efibootmgr
    
    # Theme packages
    adwaita-icon-theme
    gnome-themes-extra
    gtk3
    gtk4
    gsettings-desktop-schemas
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    libsForQt5.qt5ct
    qt6ct
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    bibata-cursors
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
