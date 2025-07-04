{
  config,
  pkgs,
  lib,
  userSettings,
  host,
  ...
}:
with lib;
with host; {
  config = mkIf (config.hyprland.enable) {
    home-manager.users.${userSettings.username} = {
      wayland.windowManager.hyprland.settings = {
        bindm = [
          "$modifier,mouse:272,movewindow"
          "$modifier,mouse:273,resizewindow"
        ];
        bind =
          [
            "$modifier,Return,exec,${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}"
            "$modifier,Q,killactive,"
            "$modifier,Escape,exit,"
            "$modifier,S,exec,${pkgs.systemd}/bin/systemctl suspend"
            "$modifier,L,exec,${pkgs.hyprlock}/bin/hyprlock"
            "$modifier,E,exec,${pkgs.xfce.thunar}/bin/thunar"
            "$modifierSHIFT,E,exec,emacsclient -c -a 'emacs' "
            "$modifier,F,togglefloating,"
            "$modifierSHIFT,Return,exec,pypr toggle term"
            "$modifier,P,pseudo,"
            ",F11,fullscreen,"
            "$modifier,R,forcerendererreload"
            "$modifierSHIFT,R,exec,${config.programs.hyprland.package}/bin/hyprctl reload"
            "$modifier,T,exec,${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal} -e nvim"
            # "$modifier,K,exec,${config.programs.hyprland.package}/bin/hyprctl switchxkblayout keychron-k8-keychron-k8 next"
            "$modifier,Z,layoutmsg,togglesplit"
            "$modifier,F1,exec,gamemode"

            "$modifier,left,movefocus,l"
            "$modifier,right,movefocus,r"
            "$modifier,up,movefocus,u"
            "$modifier,down,movefocus,d"
            "$modifierSHIFT,left,movewindow,l"
            "$modifierSHIFT,right,movewindow,r"
            "$modifierSHIFT,up,movewindow,u"
            "$modifierSHIFT,down,movewindow,d"
            "$modifier,1,workspace,1"
            "$modifier,2,workspace,2"
            "$modifier,3,workspace,3"
            "$modifier,4,workspace,4"
            "$modifier,5,workspace,5"
            "$modifier,6,workspace,6"
            "$modifier,7,workspace,7"
            "$modifier,8,workspace,8"
            "$modifier,9,workspace,9"
            "$modifier,0,workspace,10"

            "$modifierSHIFT,1,movetoworkspace,1"
            "$modifierSHIFT,2,movetoworkspace,2"
            "$modifierSHIFT,3,movetoworkspace,3"
            "$modifierSHIFT,4,movetoworkspace,4"
            "$modifierSHIFT,5,movetoworkspace,5"
            "$modifierSHIFT,6,movetoworkspace,6"
            "$modifierSHIFT,7,movetoworkspace,7"
            "$modifierSHIFT,8,movetoworkspace,8"
            "$modifierSHIFT,9,movetoworkspace,9"
            "$modifierSHIFT,0,movetoworkspace,10"

            "$modifier, mouse_down, workspace, e-1"
            "$modifier, mouse_up, workspace, e+1"

            ",print,exec,screenshot"
            # ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10"
            # ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10"
            # ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t"
            # "$modifier_L,c,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
            "CTRL,F10,exec,${pkgs.pamixer}/bin/pamixer -t"
            ",XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
            ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
            ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
            ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

            # ",XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10"
            # ",XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10"
            ",XF86MonBrightnessDown,exec,${pkgs.avizo}/bin/lightctl down"
            ",XF86MonBrightnessUP,exec,${pkgs.avizo}/bin/lightctl up"

            ",XF86AudioLowerVolume,exec,${pkgs.avizo}/bin/volumectl -u down"
            ",XF86AudioRaiseVolume,exec,${pkgs.avizo}/bin/volumectl -u up"
            ",XF86AudioMute,exec,${pkgs.avizo}/bin/volumectl toggle-mute"
            "$modifier_L,c,exec,${pkgs.avizo}/bin/volumectl -m toggle-mute"
            ",XF86AudioMicMute,exec,${pkgs.avizo}/bin/volumectl -m toggle-mute"
          ]
          ++ (
            if userSettings.style == "waybar-oglo" || userSettings.style == "waybar-curve" || userSettings.style == "waybar-jake" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-cool" || userSettings.style == "waybar-nekodyke" || userSettings.style == "waybar-ddubs"
            then [
              "$modifier,Space,exec, pkill rofi || ${pkgs.rofi-wayland}/bin/rofi -disable-history -show drun"
              "$modifier,TAB,exec,pkill -SIGUSR1 waybar"
              "$modifier, W, exec, pkill waybar && ${pkgs.waybar}/bin/waybar &"
              (
                if userSettings.style == "waybar-oglo"
                then "ALT,F4,exec,${pkgs.eww}/bin/eww open --toggle powermenu-window --screen 0"
                else "ALT,F4,exec,${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell"
              )
            ]
            else if userSettings.style == "hyprpanel"
            then [
              "$modifier,Space,exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
              "$modifier,TAB,exec,hyprpanel toggleWindow bar-0"
              "ALT,F4,exec,hyprpanel toggleWindow powerdropdownmenu"
            ]
            else if userSettings.style == "mithril"
            then [
              "$modifier,Space,exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
            ]
            else if userSettings.style == "ags"
            then [
              "$modifier,Space,exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
            ]
            else []
          );
        binde = [
          "$modifierCTRL,right,resizeactive,60 0"
          "$modifierCTRL,left,resizeactive,-60 0"
          "$modifierCTRL,up,resizeactive,0 -60"
          "$modifierCTRL,down,resizeactive,0 60"
        ];
        bindl =
          if hostName == "dell" || hostName == "nokia" || hostName == "hp"
          then [
            ",switch:on:Lid Switch,exec,${pkgs.hyprlock}/bin/hyprlock"
          ]
          else [];
        layerrule = [
          # "blur, waybar"
          "blur, rofi"
          "blur, gtk-layer-shell"
        ];
      };
    };
  };
}
