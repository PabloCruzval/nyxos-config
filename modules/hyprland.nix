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
          "GTK_THEME,Adwaita:dark"
          "QT_STYLE_OVERRIDE,kvantum-dark"
        ];
        
        # Startup applications
        exec-once = [
          "hypridle"
          "waybar -c /home/nyx/nixos-config/modules/styles/waybar.jsonc -s /home/nyx/nixos-config/modules/styles/waybar.css"
          "hyprpaper"
          "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"
          "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
          "gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'"
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
          "col.active_border" = "rgba(ffa066ff)";
          "col.inactive_border" = "rgba(1f1f28cc)";
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
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
            "linear, 0, 0, 1, 1"
            "easeInOutQuart, 0.76, 0, 0.24, 1"
            "easeOutQuart, 0.25, 1, 0.5, 1"
            "easeInOutExpo, 0.87, 0, 0.13, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "overshot, 0.13, 0.99, 0.29, 1.1"
          ];
          
          animation = [
            "windows, 1, 2, wind, slide"
            "windowsIn, 1, 2, winIn, slide"
            "windowsOut, 1, 1.5, winOut, slide"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 1, 2, linear"
            "workspaces, 1, 5, wind"
            "specialWorkspace, 1, 6, wind, slidevert"
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
          "workspace 2, title:^(.*Brave.*)$"
          "workspace 3, title:^(.*Visual Studio.*)$"
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
      
      # Essential UI components
      waybar             # Status bar
      
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
    ];
  };
}
