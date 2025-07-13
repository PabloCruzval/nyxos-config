{ config, pkgs, lib, ... }:

{
  imports = [
    ./base.nix
  ];

  # Configuración específica para torre/desktop
  home.packages = with pkgs; [
		rnote
		obs-studio
		sqlite
    postman
  ];

  # Configuración específica de monitor para desktop
  hyprland.monitor = [
    "DP-1,1920x1080@144,1920x0,1"
    "HDMI-A-1,1920x1080@60,0x0,1"
  ];

  # Configuración de workspaces por monitor para desktop
  hyprland.workspaceMonitorBindings = [
    "1, monitor:DP-1"
    "2, monitor:DP-1"
    "3, monitor:DP-1"
    "4, monitor:DP-1"
    "5, monitor:DP-1"
    "6, monitor:HDMI-A-1"
    "7, monitor:HDMI-A-1"
    "8, monitor:HDMI-A-1"
    "9, monitor:HDMI-A-1"
    "10, monitor:HDMI-A-1"
  ];

  # Variables de entorno específicas para desktop
  home.sessionVariables = {
    # NVIDIA específico
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Configuración adicional para desktop
  home.file = {
    # Configuraciones específicas si es necesario
  };
}
