{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
    ../modules/kitty.nix
    ../modules/hyprland.nix
    ../modules/hyprpaper.nix
    ../modules/rofi/rofi.nix
    ../modules/waybar/waybar.nix
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

  # Waybar status bar config
  waybar.enable = true;

  home.username = "nyx";
  home.homeDirectory = "/home/nyx";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;
  
  # Paquetes base comunes para ambos perfiles
  home.packages = with pkgs; [
    neovim
    brave
    obsidian           # Para estudiar - necesario en todos los dispositivos
    gh
    vscode-fhs
    discord
    bitwarden-desktop
    xfce.thunar
    htop               # Monitor del sistema - útil en cualquier computador
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = lib.mkDefault "nvim";
  };

  programs.home-manager.enable = true;
}
