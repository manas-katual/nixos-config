{
  pkgs,
  lib,
  userSettings,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      kitty
    ];
  };

  home-manager.users.${userSettings.username} = {
    programs.kitty = lib.mkIf (userSettings.terminal == "kitty") {
      enable = true;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        enable_audio_bell = "no";
        window_padding_width = 4;
        confirm_os_window_close = 0;
        cursor_trail = 1;
        tab_bar_edge = "top";
        tab_bar_margin_width = 0;
        tab_bar_style = "powerline";
        #background_opacity = lib.mkForce "0.90";
      };
      extraConfig = ''
        #modify_font cell_height 110%
        tab_powerline_style slanted
      '';
    };
  };
}
