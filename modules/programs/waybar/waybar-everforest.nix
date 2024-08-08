{
  programs.waybar = {
    enable = false;
    settings = {
      mainBar = {
          layer = "top";
    modules-left = ["custom/apps" "hyprland/workspaces"];
    modules-center = ["hyprland/window"];
    modules-right = ["custom/power-left-end" "group/power" "custom/tray-left-end" "group/sys-tray" "pulseaudio" "clock" "custom/notifications"];
    "custom/apps"= {
      "format"= "  ";
      "tooltip"= false;
      "on-click"= "rofi -show drun -disable-history";
    };

    "custom/notifications"= {
      "tooltip"= false;
      "format"= "{icon}";
      "format-icons"= {
        "notification"= "";
        "none"= "";
        "dnd-notification"= "";
        "dnd-none"= "";
        "inhibited-notification"= "";
        "inhibited-none"= "";
        "dnd-inhibited-notification"= "";
        "dnd-inhibited-none"= "";
      };

      "return-type"= "json";
      "exec-if"= "which swaync-client";
      "exec"= "swaync-client -swb";
      "on-click"= "swaync-client -t -sw";
      "on-click-right"= "swaync-client -d -sw";
      "escape"= true;
    };

    "custom/shutdown"= {
      "format"= "    ";
      "tooltip"= false;
      "on-click"= "$HOME/Scripts/Power/Power -s";
    };

    "custom/reboot"= {
      "format"= "  ";
      "tooltip"= false;
      "on-click"= "$HOME/Scripts/Power/Power -r";
    };

    "custom/logout"= {
      "format"= "  ";
      "tooltip"= false;
      "on-click"= "$HOME/Scripts/Power/Power -l";
    };

    "custom/firmware"= {
      "format"= "  ";
      "tooltip"= false;
      "on-click"= "$HOME/Scripts/Power/Power -f";
    };

    "custom/suspend"= {
      "format"= "  ";
      "tooltip"= false;
      "on-click"= "hyprlock & sleep 1; systemctl suspend";
    };

    "custom/divider"= {
      "format"= "|";
      "tooltip"= "flase";
    };

    "custom/power-left-end"= {
      "format"= " ";
      "tooltip"= false;
    };

    "group/power"= {
      "orientation"= "horizontal";
      "drawer"= {
        "transition-duration"= 600;
        "transition-left-to-right"= false;
      };
      "modules"= [
        "custom/shutdown"
        "custom/firmware"
        "custom/divider"
        "custom/suspend"
        "custom/divider"
        "custom/logout"
        "custom/divider"
        "custom/reboot"
        "custom/divider"
      ];
    };

    "hyprland/workspaces"= {
      active-only = "false";
      format = "{icon}";
      tooltip = "false";
      all-outputs = "true";
      format-icons = {
        "active"= "";
        "default"= "<span color='#7A8478'></span>";
      };
      "persistent-workspaces"= {
        "*"= 5;
      };
    };

    tray = {
      "icon-size"= 18;
      "spacing"= 12;
    };

    "custom/tray-collapsed"= {
      "format"= "󰇙  ";
      "tooltip"= false;
    };

    "custom/tray-left-end"= {
      "format"= " ";
      "tooltip"= false;
    };

    "group/sys-tray"= {
      "orientation"= "horizontal";
      "drawer"= {
        "transition-duration"= 600;
        "transition-left-to-right"= false;
      };
      "modules"= [
        "custom/tray-collapsed"
        "tray"
      ];
    };

    "clock" = {
      format = "<span color='#A7C080'> </span>{=%I=%M %p}";
    };

    "pulseaudio"= {
      "format"= "<span color='#A7C080'>{icon}</span> {volume}%";
      "format-muted"= "<span color ='#A7C080'></span>";
      "tooltip"= false;
      "format-icons"= {
        "headphone"= "";
        "default"= ["" "" "" "" "" ""];
      };

      "scroll-step"= 1;
    };
      };
    };

    style = ''
* {
  font-family: 'Cascadia Code', 'Symbols Nerd Font Mono';
  font-size: 14px;
  font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
  min-height: 35px;
}

/* floating */
/*
window#waybar {
  background-color: transparent;
}
*/

/* regular */
window#waybar {
  background-color: #272E33;
  border-bottom: 1px solid #374145;
}


window#waybar.empty #window {
  background-color: transparent;
  transition: none;
}

#custom-apps, #workspaces, #custom-notifications {
  color: #A7C080;
  margin-right: 15px;
  padding-left: 5px;
  padding-right: 5px;
  background-color: #2E383C;
  margin-top: 5px;
  margin-bottom: 6px;
  border-radius: 4px;
}

#custom-apps, #custom-notifications {
  font-size: 15px;
  margin-left: 15px;
  color: #A7C080;
  padding-left: 8px;
  padding-right: 8px;
}

#custom-notifications {
  margin-left: 0px;
  margin-right: 5px;
}

#custom-apps {
  margin-left: 5px;
}

#workspaces button {
  color: #A7C080;
  padding: 0 10px;
}

#workspaces button:hover {
  box-shadow: inherit;
  text-shadow: inherit;
}

#clock, #pulseaudio, #window, #tray, #custom-tray-collapsed {
  color: #D3C6AA;
  padding-left: 10px;
  padding-right: 10px;
  margin-right: 15px;
  background-color: #2E383C;
  margin-top: 5px;
  margin-bottom: 6px;
  border-radius: 4px;
}

#tray {
  border-radius: 4px 0 0 4px;
  margin-right: 0;
}

#custom-shutdown, #custom-logout, #custom-reboot, #custom-firmware, #custom-suspend, #custom-tray-collapsed {
  color: #A7C080;
  padding-left: 10px;
  padding-right: 10px;
  background-color: #2E383C;
  margin-top: 5px;
  margin-bottom: 6px;
}

#custom-divider {
  color: #A7C080;
  background-color: #2E383C;
  margin-top: 5px;
  margin-bottom: 6px;
}

#custom-shutdown, #custom-tray-collapsed {
  margin-right: 15px;
  border-radius: 0 4px 4px 0;
}

#custom-power-left-end, #custom-tray-left-end {
  background-color: #2E383C;
  border-right: none;
  border-radius: 4px 0 0 4px;
  margin-top: 5px;
  margin-bottom: 6px;
}

#window {
  transition: linear 0.3s;
}
    '';
  };
}
