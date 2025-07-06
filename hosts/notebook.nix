{ config, pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
  ];

  ##########################
  ## System Configuration ##
  ##########################

  networking.hostName = "nyxos-asus";

  ##########################
  ## Notebook Specific    ##
  ##########################

  # Gestión de energía para notebook
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  # Servicios específicos para notebook
  services.upower.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    powerKey = "suspend";
  };

  # Hardware específico para notebook
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # NVIDIA específico para notebook (gestión de energía)
  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  ##################
  ## Home Manager ##
  ##################

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "nyx" = import ../profiles/notebook.nix;
    };
  };
}
