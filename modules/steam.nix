{ lib, config, pkgs, ... }:
{
  # Instala Steam y habilita el runtime de 32 bits
  programs.steam = {
    enable = true;
    package = pkgs.steam;
    remotePlay.openFirewall = true; # Permite Remote Play
    dedicatedServer.openFirewall = true; # Permite servidores dedicados
  };

  # Habilita soporte para controladores de juegos
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Habilita soporte para 32 bits (necesario para muchos juegos)
  environment.systemPackages = with pkgs; [
    steam
    libglvnd
    libGL
    libGLU
    # Paquetes útiles para compatibilidad
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    # Soporte para controladores de gamepad
    xorg.libxcb
    xorg.libX11
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXScrnSaver
    xorg.libXtst
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXxf86vm
    xorg.libxkbfile
    xorg.libxshmfence
    # Soporte para audio
    alsaLib
    pulseaudio
  ];

  # Habilita el soporte para Flatpak (algunos juegos y Proton pueden requerirlo)
  services.flatpak.enable = true;

  # Habilita el soporte para FUSE (necesario para Proton y algunos juegos)
  boot.extraModulePackages = with config.boot.kernelPackages; [ fuse ];

  # Permite la aceleración de hardware para Steam y juegos
  hardware.nvidia.modesetting.enable = lib.mkDefault true;
  hardware.nvidia.powerManagement.enable = lib.mkDefault true;

  # Permite la ejecución de Steam como usuario normal
  users.users.nyx.extraGroups = [ "video" "audio" "input" "games" ];

  # Opcional: Habilita gamemode para optimizar el rendimiento de juegos
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs;
}
