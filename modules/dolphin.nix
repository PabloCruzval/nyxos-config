{lib, config, pkgs, ...}:

{
  options = {
    dolphin.enable = lib.mkEnableOption "enable Dolphin file manager with proper theming";
  };

  config = lib.mkIf config.dolphin.enable {
    # Install Dolphin and theme packages
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kio-extras
      kdePackages.kimageformats
      kdePackages.qtimageformats
      
      # Icon themes for proper visibility
      papirus-icon-theme
      breeze-icons
      
      # Qt theme packages
      qt6ct
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
    ];

    # Create Qt5 configuration for dark theme
    xdg.configFile."qt5ct/qt5ct.conf".text = ''
      [Appearance]
      color_scheme_path=${pkgs.qt5ct}/share/qt5ct/colors/darker.conf
      custom_palette=false
      icon_theme=Papirus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="Fira Code Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
      general="Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x2\x85\0\0\0\xaf\0\0\x5\x66\0\0\x3\x11\0\0\x2\x87\0\0\0\xb1\0\0\x5\x64\0\0\x3\xf\0\0\0\0\0\0\0\0\a\x80\0\0\x2\x87\0\0\0\xb1\0\0\x5\x64\0\0\x3\xf)
    '';

    # Create Qt6 configuration for dark theme
    xdg.configFile."qt6ct/qt6ct.conf".text = ''
      [Appearance]
      color_scheme_path=${pkgs.qt6ct}/share/qt6ct/colors/darker.conf
      custom_palette=false
      icon_theme=Papirus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="Fira Code Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
      general="Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3
    '';

    # Configure Kvantum theme
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvArcDark
    '';

    # Create Dolphin configuration for dark theme
    xdg.configFile."dolphinrc".text = ''
      [General]
      Version=202
      ViewPropsTimestamp=2024,1,1,0,0,0

      [IconsMode]
      PreviewSize=64

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=22

      [MainWindow]
      MenuBar=Disabled
      ToolBarsMovable=Disabled

      [PreviewSettings]
      Plugins=appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,textthumbnail,ffmpegthumbnails
    '';
  };
}
