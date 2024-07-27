let
	betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
in
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = {
     mainBar =  {
        layer = "top";
        position = "top";
        modules-center = [ "hyprland/workspaces" ];
        modules-left = [
          "custom/startmenu"
          "hyprland/window"
          "pulseaudio"
          "cpu"
          "memory"
          "idle_inhibitor"
        ];
        modules-right = [
          "custom/hyprbindings"
          "custom/themeselector"
          "custom/notification"
          "custom/exit"
          "battery"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = " {:L%I:%M %p}";
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/themeselector" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && theme-selector";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && wofi";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-hypr-bindings";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
      };
    };
    style = 
      ''

* {
  font-size: 16px;
  border-radius: 0px;
  border: none;
  font-family: JetBrainsMono Nerd Font Mono;
  min-height: 0px;
}

window#waybar {
  background-color: #1b2b34; /* base00 */
}

#workspaces {
  color: #1b2b34; /* base00 */
  background: #343d46; /* base01 */
  margin: 4px 4px;
  padding: 8px 5px;
  border-radius: 16px;
}

#workspaces button {
  font-weight: bold;
  padding: 0px 5px;
  margin: 0px 3px;
  border-radius: 16px;
  color: #1b2b34; /* base00 */
  background: linear-gradient(45deg, #a3b5c3, #bf616a, #e5c07b, #6699cc); /* base0E, base0F, base0D, base09 */
  background-size: 300% 300%;
  opacity: 0.5;
  transition: ${betterTransition};
}

#workspaces button.active {
  font-weight: bold;
  padding: 0px 5px;
  margin: 0px 3px;
  border-radius: 16px;
  color: #1b2b34; /* base00 */
  background: linear-gradient(45deg, #a3b5c3, #bf616a, #e5c07b, #6699cc); /* base0E, base0F, base0D, base09 */
  background-size: 300% 300%;
  transition: ${betterTransition};
  opacity: 1.0;
  min-width: 40px;
}

#workspaces button:hover {
  font-weight: bold;
  border-radius: 16px;
  color: #1b2b34; /* base00 */
  background: linear-gradient(45deg, #a3b5c3, #bf616a, #e5c07b, #6699cc); /* base0E, base0F, base0D, base09 */
  background-size: 300% 300%;
  opacity: 0.8;
  transition: ${betterTransition};
}

@keyframes gradient_horizontal {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

@keyframes swiping {
  0% {
    background-position: 0% 200%;
  }
  100% {
    background-position: 200% 200%;
  }
}

tooltip {
  background: #1b2b34; /* base00 */
  border: 1px solid #bf616a; /* base0E */
  border-radius: 12px;
}

tooltip label {
  color: #c0c5ce; /* base07 */
}

#window, #pulseaudio, #cpu, #memory, #idle_inhibitor {
  font-weight: bold;
  margin: 4px 0px;
  margin-left: 7px;
  padding: 0px 18px;
  color: #65737e; /* base05 */
  background: #343d46; /* base01 */
  border-radius: 24px 10px 24px 10px;
}

#custom-startmenu {
  color: #b48ead; /* base0D */
  background: #343d46; /* base01 */
  font-size: 28px;
  margin: 0px;
  padding: 0px 30px 0px 15px;
  border-radius: 0px 0px 40px 0px;
}

#custom-hyprbindings, #network, #custom-themeselector, #battery,
#custom-notification, #tray, #custom-exit {
  font-weight: bold;
  background: #343d46; /* base01 */
  color: #65737e; /* base05 */
  margin: 4px 0px;
  margin-right: 7px;
  border-radius: 10px 24px 10px 24px;
  padding: 0px 18px;
}

#clock {
  font-weight: bold;
  color: #1b2b34; /* base00 */
  background: linear-gradient(45deg, #bf616a, #bf616a, #b48ead, #b48ead); /* base0C, base0F, base0B, base08 */
  background-size: 300% 300%;
  margin: 0px;
  padding: 0px 15px 0px 30px;
  border-radius: 0px 0px 0px 40px;
}
              '';
  };
}
