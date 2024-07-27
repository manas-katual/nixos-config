{ config, lib, options, ... }:
{

options = lib.mkIf (config.my.desktop.option == "hyprland") {
	
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "rofi -show drun -show-icons";
      "$browser" = "firefox";
      "$lock" = "hyprlock";
      "$w1" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/random.jpg"'';
      "$w2" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/hut.jpg"'';
      "$w3" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/car.jpg"'';
      "$w4" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/sky.jpg"'';
      "$w5" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/nord_roads.png"'';
      "$w6" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/nord_lake.png"'';
      "$w7" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/ledge_gruvbox.png"'';
      "$w8" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/hyprland.png"'';
      "$w9" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/ghibli_insider.jpeg"'';
      "$w0" = ''hyprctl hyprpaper wallpaper "LVDS-1,~/setup/modules/wallpapers/wind_rises.jpeg"'';
      

      monitor = [
				#"HDMI-A-1,preferred,auto,1,mirror,LVDS-1"
				"HDMI-A-1,1366x768,auto,1,mirror,LVDS-1"
			];
      exec-once = [
        "hyprpaper"
        "waybar"
	      "hypridle"
	      "lxsession"
	      "swaync"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        #"nwg-dock-hyprland -r"
      ];

      env = [
      	#"WLR_DRM_DEVICES,$HOME/.config/hypr/card"
				"WLR_NO_HARDWARE_CURSORS,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,36"
        "QT_QPA_PLATFORM,wayland"
	      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
				#"GTK2_RC_FILES,/home/smaalks/.config/gtk-2.0/gtkrc"
				"QT_QPA_PLATFORMTHEME,qtct"
				"QT_AUTO_SCREEN_SCALE_FACTOR,1"
				"QT_STYLE_OVERRIDE,kvantum"
        #"XDG_SCREENSHOTS_DIR,~/screens"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "in";
        kb_variant = "eng";
        kb_options = "terminate:ctrl_alt_bksp";
        numlock_by_default = true;

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        # col.active_border = rgba(7aa2f7ee) rgba(87aaf8ee) 45deg # tokyonight
        # col.inactive_border = rgba(32344aaa) # tokyonight 
        # col.active_border = rgba(89b4faee) rgba(89b4faee) 45deg # catppuccin-mocha
        # col.inactive_border = rgba(1e1e2eaa) # catppuccin-mocha
        # col.active_border = rgba(7aa89faa) rgba(7fb4caaa) 45deg #kanagawa 
        # col.inactive_border = rgba(25252faa) #kanagawa
        "col.active_border" = "rgba(8ec07caa) rgba(8ec07caa) 45deg"; #gruvbox
        "col.inactive_border" = "rgba(3c3836aa)"; #gruvbox
        # col.active_border = rgba(3ddbd9aa) rgba(82cfffaa) 45deg #oxocarbon
        # col.inactive_border = rgba(262626aa) #oxocarbon
        # col.active_border = rgba(8baff1aa) rgba(86aaecaa) 45deg #decay
        # col.inactive_border = rgba(151720aa) #decay
        # col.active_border = rgba(67cbe7aa) rgba(96d988aa) 45deg #everblush
        # col.inactive_border = rgba(2d3437aa) #everblush

        layout = "master";

        #no_cursor_warps = false;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 16;
          passes = 2;
	        vibrancy = 0.5;
          new_optimizations = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        # col.shadow = rgba(1c1e27ee) #decayce
        "col.shadow" = "rgba(282828ee)"; #gruvbox
        # col.shadow = rgba(25252fee) #kanagawa
        # col.shadow = rgba(232a2daa)
    	  active_opacity = 0.9;
    	  inactive_opacity = 0.8;
      };

      animations = {
        enabled = true;

        bezier = [
 	        "pace,0.46, 1, 0.29, 0.99"
          "overshot,0.13,0.99,0.29,1.1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
        ];

        animation = [
    	    "windowsIn,1,6,md3_decel,slide"
          "windowsOut,1,6,md3_decel,slide"
          "windowsMove,1,6,md3_decel,slide"
          "fade,1,10,md3_decel"
          "workspaces,1,7,md3_decel,slide"
          "specialWorkspace,1,8,md3_decel,slide"
          "border,0,3,md3_decel"
        ];
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      #master = {
      #  new_is_master = true;
      #};

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = false;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
      };

      windowrule = [
        "float, ^(imv)$"
        "float, ^(mpv)$"
        "float, ^(eog)$"
      ];

			windowrulev2 = [
				"float, class:(brave),title:(Save File)"
				"float, class:(kitty),title:(nmtui)"
			];


      bind = [

        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod SHIFT, F, exec, $fileManager"
        "$mainMod, E, exec, emacsclient -c"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, B, exec, $browser"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, T, togglesplit, # dwindle"
        "$mainMod, F, fullscreen # dwindle"
        "Alt, F4, exec, wlogout -b 2 # wlogout"

        # waybar
        "$mainMod SHIFT, C, exec, pkill waybar && waybar"


	      # hyprpaper
	      "$mainMod SHIFT, Q, exec, $w1"
	      "$mainMod SHIFT, W, exec, $w2"
	      "$mainMod SHIFT, E, exec, $w3"
        "$mainMod SHIFT, R, exec, $w4"
        "$mainMod SHIFT, T, exec, $w5"
        "$mainMod SHIFT, Y, exec, $w6"
        "$mainMod SHIFT, U, exec, $w7"
        "$mainMod SHIFT, I, exec, $w8"
        "$mainMod SHIFT, O, exec, $w9"
	      "$mainMod SHIFT, P, exec, $w0"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Switch workspaces with mainMod + [0-9]
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

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # brightness control
        "$mainMod, F3, exec, brightnessctl -d *::kbd_backlight set +33%"
        "$mainMod, F2, exec, brightnessctl -d *::kbd_backlight set 33%-"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
        ", XF86AudioLowerVolume, exec, pamixer -d 5 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"
        
        # Brightness control
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
        ", XF86MonBrightnessUp, exec, brightnessctl set +5% "

        # Configuration files
        #'', Print, exec, grim -g "$(slurp)" - | swappy -f -''
	      # Screenshot with selection
	      '', Print, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send "Screenshot of the region taken" -t 1000'' 

	      # Whole screen Screenshot
	      ''SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send "Screenshot of whole screen taken" -t 1000'' 

	      # current window (pos and size)
	      ''ALT, Print, exec, grim -g "$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1) $(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send "Screenshot of current window taken" -t 1000 ''

	      # screenlock
	      "$mainMod, L, exec, $lock"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"


      ];
    };
  };
};
}
