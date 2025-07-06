{ config, pkgs, inputs,... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];
  ##########################
  ## System Configuration ##
  ##########################

  networking.hostName = "nixos";
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
    powerManagement.enable = false;
    powerManagement.finegrained = false;
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
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

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
  programs.firefox.enable = true;

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


  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nyx" = import ./home.nix;
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
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
