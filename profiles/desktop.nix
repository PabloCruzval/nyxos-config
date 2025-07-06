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

  # Variables de entorno específicas para desktop
  home.sessionVariables = {
    EDITOR = "nvim";
    # NVIDIA específico
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Configuración adicional para desktop
  home.file = {
    # Configuraciones específicas si es necesario
  };
}
