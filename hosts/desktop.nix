{ config, pkgs, inputs, ... }:

{
  imports = [
    ../hc-desktop.nix
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
  # Se mantiene el valor por defecto (false) del archivo base

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
