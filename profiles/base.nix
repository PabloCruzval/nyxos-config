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
  
  # Cursor theme configuration
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
  
  # GTK theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Bibata-Modern-Classic";
      gtk-cursor-theme-size = 24;
    };
    gtk4.extraConfig = {
      gtk-cursor-theme-name = "Bibata-Modern-Classic";
      gtk-cursor-theme-size = 24;
    };
  };
  
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
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  programs.home-manager.enable = true;
}
