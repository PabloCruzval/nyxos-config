{lib, config, pkgs, ...}:

{
  options = {
    kitty.enable = lib.mkEnableOption "enable kitty terminal emulator";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        hide_window_decorations = true;
        disable_ligatures = false;
        font_family = "FiraCode Nerd Font";
        remember_window_size = false;
        initial_window_width = 1920;
        initial_window_height = 1080;
        window_padding_width = 8;
        cursor_shape = "beam";
        cursor_beam_thickness = 1.4;
        mouse_hide_wait = 3.0;
        detect_url = true;
        repaint_delay = 10;
        input_delay = 3;
        sync_to_monitor = true;
        tab_bar_style = "powerline";
        
        # Background opacity
        background_opacity = "0.85";
        
        # Colors - Kanagawa theme
        foreground = "#dcd7ba";
        background = "#1f1f28";
        
        # Black
        color0 = "#090618";
        color8 = "#727169";
        
        # Red
        color1 = "#c34043";
        color9 = "#e82424";
        
        # Green
        color2 = "#76946a";
        color10 = "#98bb6c";
        
        # Yellow
        color3 = "#c0a36e";
        color11 = "#e6c384";
        
        # Blue
        color4 = "#7e9cd8";
        color12 = "#7fb4ca";
        
        # Magenta
        color5 = "#957fb8";
        color13 = "#938aa9";
        
        # Cyan
        color6 = "#6a9589";
        color14 = "#7aa89f";
        
        # White
        color7 = "#c8c093";
        color15 = "#dcd7ba";
        
        # Cursor
        cursor = "#c8c093";
        cursor_text_color = "#1f1f28";
        
        # Selection highlight
        selection_foreground = "#c8c093";
        selection_background = "#2d4f67";
        
        # Tabs
        inactive_tab_background = "#16161d";
        active_tab_background = "#1f1f28";
        inactive_tab_foreground = "#727169";
        tab_bar_margin_color = "#16161d";
        
        # URL
        url_color = "#7e9cd8";
      };
    };
  };
}