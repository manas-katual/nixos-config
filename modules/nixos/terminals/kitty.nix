{ userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    programs.kitty = {
      enable = true;
      font = {
        name = "Intel One Mono";
        size = 14;
      };
      theme = "Gruvbox Dark Soft";
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 2;
        confirm_os_window_close = 0;
        background_opacity = "0.90";
      }; 
      extraConfig = ''
        #modify_font cell_height 110% 
        tab_bar_edge top
        tab_bar_style powerline
        tab_powerline_style slanted
      '';
    };
  };
}
