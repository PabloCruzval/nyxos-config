{ config, pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
  ];

  ##########################
  ## System Configuration ##
  ##########################

  networking.hostName = "nyx-pcmasterrace";

  ##########################
  ## Desktop Specific     ##
  ##########################

  # NVIDIA específico para desktop (sin gestión de energía)
  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  ##################
  ## Home Manager ##
  ##################

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "nyx" = import ../profiles/desktop.nix;
    };
  };
}
