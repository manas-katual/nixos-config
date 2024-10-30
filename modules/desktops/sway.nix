{ config, lib, pkgs, userSettings, host, ... }:

with lib;
with host;
{
  options = {
    sway = {
      enable = mkOption {
        type = types.bool;
	default = false;
      };
    };
  };

  config = mkIf (config.sway.enable) {
    wlwm.enable = true;

    environment = {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
	  exec sway
	fi
      '';
      variables = {
        WLR_NO_HARDWARE_CURSORS = "1"; 
      };
    };

    programs = {
      sway = {
        enable = true;
	extraPackages = with pkgs; [
	  autotiling
	  wl-clipboard
	  wlr-randr
	  xwayland
	];
      };
    };

    home-manager.users.${userSettings.username} = {
      wayland.windowManager.sway = {
        enable = true;
	config = rec {
	  modifier = "Mod4";
	  terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
	  menu = "${pkgs.wofi}/bin/wofi --show drun --allow-images --sort-order=alphabetical";

	  startup = [
	    { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
	  ];

	  bars = [
	    {
	      command = "${pkgs.waybar}/bin/waybar";
	    }
	  ];

	  window = {
	    titlebar = false;
	  };

	  #fonts = {};

          gaps = {
            inner = 5;
            outer = 5;
          };

          input = {
            # Input modules: $ man sway-input
            "type:touchpad" = {
              tap = "enabled";
              dwt = "enabled";
              scroll_method = "two_finger";
              middle_emulation = "enabled";
              natural_scroll = "enabled";
            };
            "type:keyboard" = {
              xkb_layout = "in";
	      xkb_variant = "eng";
              xkb_numlock = "enabled";
            };
          };

	  #output = {};

	  keybindings = {
	    "${modifier}+Escape" = "exec swaymsg exit";
	    "${modifier}+Return" = "exec ${terminal}";
	    "${modifier}+space" = "exec ${menu}";

	    "${modifier}+r" = "reload";
	    "${modifier}+q" = "kill";
	    "${modifier}+f" = "fullscreen toggle";
	    "${modifier}+h" = "floating toggle";

	    "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            "${modifier}+Shift+Left" = "move container to workspace prev, workspace prev";
            "${modifier}+Shift+Right" = "move container to workspace next, workspace next";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";



	    "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
	
            "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
            "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
            "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

            "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U  5";
            "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
	  };
	};
        extraConfig = ''
	  exec ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
          set $opacity 0.8
          for_window [class=".*"] opacity 0.95
          for_window [app_id=".*"] opacity 0.95
          #for_window [app_id="thunar"] opacity 0.95, floating enable
          for_window [app_id="com.github.weclaw1.ImageRoll"] opacity 0.95, floating enable
          for_window [app_id="kitty"] opacity $opacity
          for_window [title="drun"] opacity $opacity
          #for_window [class="Emacs"] opacity $opacity
          for_window [app_id="pavucontrol"] floating enable, sticky
          for_window [app_id="Authentication Required"] floating enable, sticky
          #for_window [app_id=".blueman-manager-wrapped"] floating enable
          for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
        ''; # $ swaymsg -t get_tree or get_outputs
        extraSessionCommands = ''
          #export WLR_NO_HARDWARE_CURSORS="1";  # Needed for cursor in vm
          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_CURRENT_DESKTOP=sway
        '';
      };
    };
  

  };
}
