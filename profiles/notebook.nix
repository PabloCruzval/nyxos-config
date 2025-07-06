{ config, pkgs, lib, ... }:

{
  imports = [
    ./base.nix
  ];

  # Configuración específica para notebook
  home.packages = with pkgs; [
    # Paquetes específicos para notebook
    brightnessctl      # Control de brillo
    powertop           # Monitoreo de energía
    acpi               # Información de batería
  ];

  # Variables de entorno específicas para notebook
  home.sessionVariables = {
    EDITOR = "nvim";
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
