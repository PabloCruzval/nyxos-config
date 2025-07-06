{ config, pkgs, lib, ... }:

{
  imports = [
    ./base.nix
  ];

  # Configuración específica para torre/desktop
  home.packages = with pkgs; [
    # Monitoreo específico para NVIDIA
    nvtop              # Monitor GPU NVIDIA
  ];

  # Configuración específica de monitor para desktop
  hyprland.monitor = [
    ",preferred,auto,1"  # Auto-detect monitor resolution and position
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
