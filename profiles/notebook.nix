{ config, pkgs, lib, ... }:

{
  imports = [
    ./base.nix
		../modules/jetbrains.nix
  ];

  # Configuración específica para notebook
  home.packages = with pkgs; [
    # Paquetes específicos para notebook
    brightnessctl      # Control de brillo
    powertop           # Monitoreo de energía
    acpi               # Información de batería
  ];

  # Configuración específica de monitor para notebook
  hyprland.monitor = [
    "eDP-1,1920x1080@60,0x0,1"
  ];

  # Variables de entorno específicas para notebook
  home.sessionVariables = {
    # Optimizaciones para batería
    POWERSAVE = "1";
  };

  # Configuración adicional para notebook
  home.file = {
    # Configuración específica para gestión de energía
    ".config/tlp/tlp.conf".text = ''
      TLP_ENABLE=1
      TLP_DEFAULT_MODE=BAT
      CPU_SCALING_GOVERNOR_ON_AC=performance
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      SOUND_POWER_SAVE_ON_AC=0
      SOUND_POWER_SAVE_ON_BAT=1
    '';
  };
}
