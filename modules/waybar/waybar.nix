{lib, config, pkgs, ...}:

{
  options = {
    waybar.enable = lib.mkEnableOption "enable waybar status bar";
    waybar.persistentWorkspaces = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
      description = "Persistent workspaces configuration for waybar";
      example = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
        "6" = [];
        "7" = [];
        "8" = [];
        "9" = [];
        "10" = [];
      };
    };
    waybar.modules = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Additional modules configuration for waybar";
    };
  };

  config = lib.mkIf config.waybar.enable {
    # Generate waybar configuration
    home.file.".config/waybar/config".text = builtins.toJSON {
      margin = lib.mkDefault "20 20 0 20";
      modules-left = lib.mkDefault ["hyprland/workspaces" "hyprland/language"];
      modules-center = lib.mkDefault ["hyprland/window"];
      modules-right = lib.mkDefault ["tray" "pulseaudio" "clock" "battery"];

      "hyprland/workspaces" = {
        format = "";
        persistent-workspaces = config.waybar.persistentWorkspaces;
      };

      "hyprland/language" = {
        format = "{}";
        format-en = "EN";
        format-es = "SP";
      };

      battery = {
        interval = 10;
        states = {
          critical = 15;
          warning = 30;
          low = 50;
          medium = 75;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-charging-full = "󰂄 {capacity}%";
        format-discharging = "{icon} {capacity}%";
        format-empty = "{icon} {capacity}%";
        format-icons = {
          charging = "󰂄";
          charging-full = "󰂄";
          discharging = ["" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          empty = "󰂎";
          full = "󰁹";
          default = "�";
        };
      };

      network = {
        interval = 3;
        interface = "enp3s0";
        format = "{ifname}";
        format-ethernet = " {bandwidthDownBytes} |  {bandwidthUpBytes}";
        tooltip-format-ethernet = "iframe: {ifname}  ";
        max-length = 50;
      };

      tray = {
        icon-size = 18;
        spacing = 10;
      };

      pulseaudio = {
        scroll-step = 5;
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "  {icon} {format_source}";
        format-muted = "  {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "󱥋 ";
          headset = "󰋎 ";
          phone = "";
          portable = "";
          car = "";
          default = [" " "  " " "];
        };
        on-click = "pavucontrol";
        min-length = 13;
      };

      clock = {
        format = "  {:%I:%M %p}";
      };
    } // config.waybar.modules;

    # Copy CSS file
    home.file.".config/waybar/style.css".source = ./waybar.css;

    # Install waybar
    home.packages = with pkgs; [
      waybar
    ];
  };
}
