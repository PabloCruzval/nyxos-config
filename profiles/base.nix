{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
    ../modules/kitty.nix
    ../modules/hyprland.nix
    ../modules/hyprpaper.nix
    ../modules/rofi/rofi.nix
  ];

  # Git config
  git.enable = true;
  git.userName = "PabloCruzval";
  git.userEmail = "p.cruzat.valenzuela@gmail.com";

  # Zsh config
  zsh.enable = true;

  # Kitty terminal config
  kitty.enable = true;

  # Hyprland window manager config
  hyprland.enable = true;

  # Hyprpaper wallpaper daemon config
  hyprpaper.enable = true;
  hyprpaper.wallpaper = "/home/nyx/nixos-config/Wallpaper/KanagawaOnePiece.jpg";

  # Rofi application launcher config
  rofi.enable = true;
  rofi.theme = "/home/nyx/nixos-config/modules/rofi/rofi.rasi";

  home.username = "nyx";
  home.homeDirectory = "/home/nyx";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;
  
  # Paquetes base comunes para ambos perfiles
  home.packages = with pkgs; [
    # Desarrollo y herramientas
    neovim
    vscode-fhs
    gh
    htop

    # Aplicaciones de escritorio
    brave
    obsidian
    discord
    spotify
    figma-linux
    bitwarden-desktop
    xfce.thunar
    syncthing
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = lib.mkDefault "nvim";
  };

  programs.home-manager.enable = true;
}
