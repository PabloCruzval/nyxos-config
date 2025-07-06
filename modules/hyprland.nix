{lib, config, pkgs, ...}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland window manager";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # Programs
        "$browser" = "brave";
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun -show-icons";
        
        # Monitors
        monitor = [
          "HDMI-A-1,1920x1080@144,0x0,1"
          "eDP-1,1920x1080@60,1920x0,1"
        ];
        
        # Environment variables
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "XDG_MENU_PREFIX,arch-"
        ];
        
        # Startup applications
        exec-once = [
          "hypridle"
          "waybar -c ~/nixos-config/modules/styles/waybar.jsonc -s ~/nixos-config/modules/styles/waybar.css"
          "hyprpaper"
        ];
        
        # Theme settings
        exec = [
          "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
          "gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3\""
          "kbuildsycoca6"
        ];
        
        # Input configuration
        input = {
          kb_layout = "us,latam";
          kb_options = "caps:escape,grp:alt_shift_toggle";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = false;
          };
        };
        
        # Gestures
        gestures = {
          workspace_swipe = true;
        };
        
        # Per-device config
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };
        
        # General configuration
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 3;
          "col.active_border" = "rgba(223249ff)";     # Kanagawa WaveBlue
          "col.inactive_border" = "rgba(1f1f28cc)";   # Kanagawa SumiInk
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };
        
        # Decoration
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(0,0,0,.5)";
          };
          
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        
        # Animations
        animations = {
          enabled = true;
          
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };
        
        # Dwindle layout
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        
        # Master layout
        master = {
          new_status = "master";
        };
        
        # Misc
        misc = {
          middle_click_paste = false;
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
        
        # Window rules
        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
        
        # Main modifier
        "$mainMod" = "SUPER";
        
        # Key bindings
        bind = [
          # Applications
          "$mainMod, Return, exec, $terminal"
          "$mainMod, Q, killactive,"
          "$mainMod SHIFT, M, exit,"
          "$mainMod, M, fullscreen, 0"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, SUPER_L, exec, $menu"
          "$mainMod, B, exec, $browser"
          "$mainMod, P, pseudo,"
          "$mainMod, T, togglesplit,"
          "$mainMod, O, exec, obsidian"
          "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
          
          # Move focus (vim-like)
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          
          # Switch workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          
          # Move active window to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          
          # Scroll through workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];
        
        # Multimedia keys
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];
        
        # Media control
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
        
        # Mouse bindings
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
    
    # Install essential packages for your Hyprland setup
    home.packages = with pkgs; [
      # Core Hyprland ecosystem
      hypridle           # Idle daemon
      hyprlock           # Lock screen
      hyprpaper          # Wallpaper daemon
      
      # Applications mentioned in config
      rofi-wayland       # Application launcher
      waybar             # Status bar
      kdePackages.dolphin # File manager (Qt 6 version)
      
      # Utilities
      grim               # Screenshot tool
      slurp              # Screen area selection
      wl-clipboard       # Clipboard utilities
      brightnessctl      # Brightness control
      playerctl          # Media control
      
      # Audio
      wireplumber        # Audio server
      
      # Theme/appearance
      adw-gtk3           # GTK3 theme
      qt6ct              # Qt6 theme manager
      kdePackages.qtstyleplugin-kvantum # Qt theme engine
    ];
  };
}
