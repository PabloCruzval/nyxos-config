{lib, config, pkgs, ...}:

{
  options = {
    neovim.enable = lib.mkEnableOption "enable Neovim editor";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      extraConfig = lib.fileContents ./init.lua;
    };
  }
}