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
        window_padding_width = 0;
        cursor_shape = "beam";
        cursor_beam_thickness = 1.4;
        mouse_hide_wait = 3.0;
        detect_url = true;
        repaint_delay = 10;
        input_delay = 3;
        sync_to_monitor = true;
        tab_bar_style = "powerline";
      };
    };
  };
}