{lib, config, pkgs, ...}:

{
  options = {
    hyprpaper.enable = lib.mkEnableOption "enable hyprpaper wallpaper daemon";
    hyprpaper.wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "/home/nyx/nixos-config/Wallpaper/KanagawaOnePiece.jpg";
      description = "Path to the wallpaper image";
    };
  };

  config = lib.mkIf config.hyprpaper.enable {
    # Install hyprpaper
    home.packages = with pkgs; [
      hyprpaper
    ];

    # Create hyprpaper configuration using xdg.configFile
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      # Preload wallpaper
      preload = ${config.hyprpaper.wallpaper}
      
      # Set wallpaper for each monitor
      wallpaper = HDMI-A-1,${config.hyprpaper.wallpaper}
      wallpaper = eDP-1,${config.hyprpaper.wallpaper}
      
      # Enable splash screen
      splash = false
      
      # Enable IPC
      ipc = on
    '';
  };
}
