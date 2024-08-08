{
  programs.waybar = {
    enable = false;
    settings = {
      mainBar = {
     layer = "top"; 
    height = 20; 
    modules-left = ["sway/workspaces" "sway/mode" "custom/media"];
    modules-center = ["sway/window"];
    modules-right = ["pulseaudio" "network" "backlight" "battery" "battery#bat2" "clock" "tray"];
    # Modules configuration
    # "sway/workspaces"= {
    #     "disable-scroll"= true;
    #     "all-outputs"= true;
    #     "format"= "{name}= {icon}";
    #     "format-icons"= {
    #         "1"= "";
    #         "2"= "";
    #         "3"= "";
    #         "4"= "";
    #         "5"= "";
    #         "urgent"= "";
    #         "focused"= "";
    #         "default"= ""
    #     };
    "sway/mode"= {
        "format"= "<span style=\"italic\">{}</span>";
    };
    "mpd"= {
        "format"= "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime=%M=%S}/{totalTime=%M=%S}) ⸨{songPosition}|{queueLength}⸩ ";
        "format-disconnected"= "Disconnected ";
        "format-stopped"= "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        "unknown-tag"= "N/A";
        "interval"= 2;
        "consume-icons"= {
            "on"= " ";
        };
        "random-icons"= {
            "off"= "<span color=\"#f53c3c\"></span> ";
            "on"= " ";
        };
        "repeat-icons"= {
            "on"= " ";
        };
        "single-icons"= {
            "on"= "1 ";
        };
        "state-icons"= {
            "paused"= "";
            "playing"= "";
        };
        "tooltip-format"= "MPD (connected)";
        "tooltip-format-disconnected"= "MPD (disconnected)";
    };
    "idle_inhibitor"= {
        "format"= "{icon}";
        "format-icons"= {
            "activated"= "";
            "deactivated"= "";
        };
    };
    "tray"= {
        # "icon-size"= 21;
        "spacing"= 10;
    };
    "clock"= {
        # "timezone"= "America/New_York";
        "tooltip-format"= "<big>{=%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt"= "{=%Y-%m-%d}";
    };
    "cpu"= {
        "format"= "{usage}% ";
        "tooltip"= false;
    };
    "memory"= {
        "format"= "{}% ";
    };
    "temperature"= {
        # "thermal-zone"= 2;
        # "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
        "critical-threshold"= 80;
        # "format-critical"= "{temperatureC}°C {icon}";
        "format"= "{temperatureC}°C {icon}";
        "format-icons"= ["" "" ""];
    };
    "backlight"= {
        # "device"= "acpi_video1";
        "format"= "{percent}% {icon}";
        "format-icons"= ["" ""];
    };
    "battery"= {
        "states"= {
            # "good"= 95;
            "warning"= 30;
            "critical"= 15;
        };
        "format"= "{capacity}% {icon}";
        "format-charging"= "{capacity}% ";
        "format-plugged"= "{capacity}% ";
        "format-alt"= "{time} {icon}";
        # "format-good"= ""; // An empty format will hide the module
        # "format-full"= "";
        "format-icons"= ["" "" "" "" ""];
    };
    "battery#bat2"= {
        "bat"= "BAT2";
    };
    "network"= {
        # "interface"= "wlp2*"; # (Optional) To force the use of this interface
        "format-wifi"= "{essid} ({signalStrength}%) ";
        "format-ethernet"= "{ifname}= {ipaddr}/{cidr} ";
        "format-linked"= "{ifname} (No IP) ";
        "format-disconnected"= "Disconnected ⚠";
        "format-alt"= "{ifname}= {ipaddr}/{cidr}";
    };
    "pulseaudio"= {
        # "scroll-step"= 1; // %; can be a float
        "format"= "{volume}% {icon} {format_source}";
        "format-bluetooth"= "{volume}% {icon} {format_source}";
        "format-bluetooth-muted"= " {icon} {format_source}";
        "format-muted"= " {format_source}";
        "format-source"= "{volume}% ";
        "format-source-muted"= "";
        "format-icons"= {
            "headphone"= "";
            "hands-free"= "";
            "headset"= "";
            "phone"= "";
            "portable"= "";
            "car"= "";
            "default"= ["" "" ""];
        };
        "on-click"= "pavucontrol";
    };
};
      };
    style = ''
      * {
    border: none;
    border-radius: 4px;
    /* `ttf-font-awesome` is required to be installed for icons */
    font-family: "Roboto Mono Medium", Helvetica, Arial, sans-serif;

    /* adjust font-size value to your liking: */
    font-size: 22px;

    min-height: 0;
}

window#waybar {
    background-color: rgba(50, 50, 50, 0.9);
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
    border-radius: 0;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

#workspaces button {
    padding: 0 0.4em;
    background-color: transparent;
    color: #ffffff;
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.focused {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    border-bottom: 3px solid #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#backlight,
#network,
#pulseaudio,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#mpd {
    padding: 0 10px;
    margin: 6px 3px; 
    color: #333333;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #bbccdd;
}

#battery {
    background-color: #bbccdd;
    color: #333333;
}

#battery.charging {
    color: #ffffff;
    background-color: #26A65B;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #333333;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #2ecc71;
    color: #333333;
}

#memory {
    background-color: #9b59b6;
}

#backlight {
    background-color: #bbccdd;
}

#network {
    background-color: #bbccdd;
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: #bbccdd;
    color: #333333;
}

#pulseaudio.muted {
    background-color: #bbccdd;
    color: #333333;
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    background-color: #f0932b;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#tray {
    background-color: #2980b9;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #bbccdd;
    color: #333333;
    padding: 0 5px;
    margin: 6px 3px;
    min-width: 16px;
}
    '';
  };
}
