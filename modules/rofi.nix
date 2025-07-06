{lib, config, pkgs, ...}:

{
  options = {
    rofi.enable = lib.mkEnableOption "enable rofi application launcher";
    rofi.theme = lib.mkOption {
      type = lib.types.str;
      default = "/home/nyx/nixos-config/modules/styles/rofi.rasi";
      description = "Path to the rofi theme file";
    };
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = config.rofi.theme;
      
      # Additional rofi configuration
      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = " Apps ";
        display-run = " Run ";
        display-window = " Window ";
        display-Network = " Network ";
        sidebar-mode = true;
      };
    };

    # Install rofi-wayland package
    home.packages = with pkgs; [
      rofi-wayland
    ];
  };
}
