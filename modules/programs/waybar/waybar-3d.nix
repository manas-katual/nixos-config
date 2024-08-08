{
	programs.waybar = {
		enable = false;
		style = ''
			@define-color foreground  #ebdbb2;
@define-color foreground-disabled  #282828;
@define-color background  #1d2021;
@define-color background2  #1f2223;
@define-color background2-bottom  #191c1d;
@define-color background3  #303030;
@define-color background3-bottom  #272727;
@define-color background4  #282828;
@define-color background4-bottom  #252c32;
@define-color window-border  #689d6a;
@define-color window-border-inactive  #1d2021;
@define-color close-button  #e23c2c;
@define-color close-button-bottom  #cc241d;
@define-color close-button-foreground  #282828;
@define-color powermenu-button  #e23c2c;
@define-color powermenu-button-bottom  #cc241d;
@define-color powermenu-button-foreground  #282828;
@define-color slider  #689d6a;
@define-color metric-slider  #689d6a;
@define-color metric-slider-background  #3c3836;
@define-color metric-slider-foreground  #8ec07c;
@define-color button  #689d6a;
@define-color button-bottom  #518554;
@define-color button-active  #7db37e;
@define-color button-bottom-active  #659a68;
@define-color button-hover  #8ec07c;
@define-color button-bottom-hover  #76a765;
@define-color button-foreground  #282828;
@define-color cc-bg  #1d2021;
@define-color noti-border-color  #689d6a;
@define-color noti-border-color-critical  #cc241d;
@define-color noti-bg  #1d2021;
@define-color noti-bg-darker  #1d2021;
@define-color noti-bg-hover  #1d2021;
@define-color noti-close-bg  #3c3836;
@define-color noti-close-bg-hover  #cc241d;
@define-color dnd-bg  #3c3836;
@define-color dnd-selected  #689d6a;
@define-color dnd-dot  #282828;
@define-color noti-button  #282828;
@define-color noti-button-hover  #3c3836;
@define-color waybar-module-foreground  #282828;
@define-color waybar-clock  #98971a;
@define-color waybar-clock-bottom  #828200;
@define-color waybar-battery  #5d9da0;
@define-color waybar-battery-bottom  #458588;
@define-color waybar-battery-critical  #e23c2c;
@define-color waybar-battery-bottom-critical  #cc241d;
@define-color waybar-cpu  #689d6a;
@define-color waybar-cpu-bottom  #518554;
@define-color waybar-memory  #c8779b;
@define-color waybar-memory-bottom  #b16286;
@define-color waybar-backlight  #98bbad;
@define-color waybar-backlight-bottom  #80a295;
@define-color waybar-pulseaudio  #f2b13c;
@define-color waybar-pulseaudio-bottom  #d79921;
@define-color waybar-tray  #ec7024;
@define-color waybar-tray-bottom  #d05806;
@define-color terminal-black  #323536;
@define-color terminal-black-bright  #444748;
@define-color terminal-red  #cc241d;
@define-color terminal-red-bright  #fb4934;
@define-color terminal-green  #98971a;
@define-color terminal-green-bright  #b8bb26;
@define-color terminal-yellow  #d79921;
@define-color terminal-yellow-bright  #fabd2f;
@define-color terminal-blue  #458588;
@define-color terminal-blue-bright  #83a598;
@define-color terminal-magenta  #b16286;
@define-color terminal-magenta-bright  #d3869b;
@define-color terminal-cyan  #689d6a;
@define-color terminal-cyan-bright  #8ec07c;
@define-color terminal-white  #ebdbb2;
@define-color terminal-white-bright  #fbf1c7;



* {
    font-family: JetBrainsMono Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 14px;
    font-weight: bold;
}

window#waybar {
    background-color: @background2;
    border-bottom: 8px solid @background2-bottom;
    color: @foreground;
    transition-property: background-color;
    transition-duration: .5s;
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

button {
    all: unset;
    background-color: @button;
    color: @button-foreground;
    border: none;
    border-bottom: 8px solid @button-bottom;
    border-radius: 5px;
    margin-left: 4px;
    margin-bottom: 2px;
    font-family: JetBrainsMono Nerd Font, sans-sherif;
    font-weight: bold;
    font-size: 14px;
    padding-left: 15px;
    padding-right: 15px;
    transition: transform 0.1s ease-in-out;
}

button:hover {
    background: inherit;
    background-color: @button-hover;
    border-bottom: 8px solid @button-bottom-hover;
}

button.active {
    background: inherit;
    background-color: @button-active;
    border-bottom: 8px solid @button-bottom-active;
}

#mode {
    background-color: #64727D;
    border-bottom: 3px solid #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#custom-swaync,
#custom-menu,
#mpd {
    padding: 0 10px;
    color: #ffffff;
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

#window {
    background-color: @background3;
    color: @foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @background3-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
    padding-left: 10px;
    padding-right: 10px;
}

#custom-swaync {
    background-color: @button;
    color: @button-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @button-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
    padding-left: 13px;
    padding-right: 9px;
}

#custom-menu {
    background-color: @button;
    color: @button-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @button-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
    padding-left: 14px;
    padding-right: 8px;
}

#custom-powermenu {
    background-color: @powermenu-button;
    color: @powermenu-button-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 22px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @powermenu-button-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
    margin-right: 4px;
    padding-left: 14px;
    padding-right: 7px;
}

#clock {
    background-color: @waybar-clock;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-clock-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

#battery {
    background-color: @waybar-battery;
    color: @--waybar-module-foreground--;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-battery-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: @waybar-battery-critical;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-battery-bottom-critical;
    border-radius: 5px;
    margin-bottom: 2px;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: @waybar-cpu;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-cpu-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

#memory {
    background-color: @waybar-memory;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-memory-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

#disk {
    background-color: #964B00;
}

#backlight {
    background-color: @waybar-backlight;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-backlight-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

#network {
    background-color: #2980b9;
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: @waybar-pulseaudio;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-pulseaudio-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

/*
#pulseaudio.muted {
    background-color: #90b1b1;
    color: #2a5c45;
}
*/

#wireplumber {
    background-color: #fff0f5;
    color: #000000;
}

#wireplumber.muted {
    background-color: #f53c3c;
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
    background-color: @waybar-tray;
    color: @waybar-module-foreground;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-bottom: 8px solid @waybar-tray-bottom;
    border-radius: 5px;
    margin-bottom: 2px;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #eb4d4b;
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
    background: #00b093;
    color: #740864;
    padding: 0 5px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state {
    background: #97e1ad;
    color: #000000;
    padding: 0 0px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state > label {
    padding: 0 5px;
}

#keyboard-state > label.locked {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
	background-color: transparent;
}

tooltip {
  background-color: @background2;
  border: none;
  border-bottom: 8px solid @background2-bottom;
  border-radius: 5px;
}

tooltip decoration {
  box-shadow: none;
}

tooltip decoration:backdrop {
  box-shadow: none;
}

tooltip label {
  color: @foreground;
  font-family: JetBrainsMono Nerd Font, monospace;
  font-size: 16px;
  padding-left: 5px;
  padding-right: 5px;
  padding-top: 0px;
  padding-bottom: 5px;
}	
		'';

		settings = {
			mainBar = {
				layer = "top";
    		height = 30;
    		spacing = "4";
    		modules-left = ["hyprland/workspaces" "hyprland/window"];
    		modules-right =  ["custom/swaync" "clock" "custom/menu" "pulseaudio" "cpu" "memory" "backlight" "battery" "tray" "custom/powermenu"];


  "hyprland/workspaces" = {
		on-click = "activate";
    };

    "custom/powermenu"= {
			format = " ";
			on-click = "wlogout -b 2 --protocol layer-shell";
			tooltip = "false";
    };
		
    "custom/swaync"= {
			format = " ";
			on-click = "~/.config/hypr/swaync/scripts/tray_waybar.sh";
    	on-click-right = "swaync-client -C";
			tooltip = "false";
    };

    "custom/menu"= {
			format = " ";
			on-click = "~/.config/hypr/waybar/scripts/bar_menu.sh";
			tooltip = "false";
    };

    "keyboard-state"= {
      numlock = "true";
      capslock = "true";
      format = "{name} {icon}";
      "format-icons" = {
        locked = "";
        unlocked = "";
      };
    };

    "idle_inhibitor"= {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
        };
    };

    "tray" = {
    	spacing = "10";
    };

    "clock" = {
      tooltip-format = "{=%H=%M}";
      tooltip= "true";
      format-alt = "{:%A, %B %d, %Y}";
	    format = "{:%I:%M:%p}";
    };

    "cpu"= {
      format = "{usage}% ";
      tooltip = "false";
    };

    memory = {
    	format = "{}% ";
    };

    "temperature"= {
      critical-threshold = "80";
      format = "{temperatureC}°C {icon}";
      format-icons = ["" "" ""];
    };

    "backlight"= {
      format = "{percent}% {icon}";
      format-icons = ["" "" "" "" "" "" "" "" ""];
      tooltip-format = "Left click to save brightness";
	    on-click = "~/.config/hypr/waybar/scripts/save_brightness.sh";
	    on-click-right = "~/.config/hypr/waybar/scripts/load_brightness.sh";
    };

    "battery"= {
      "states"= {
        warning= "30";
        critical= "15";
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}%  ";
        format-plugged = "{capacity}%  ";
        format-alt = "{time} {icon}";
        format-icons = [" " " " " " " " " "];
    };

    "network" = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}= {ipaddr}/{cidr}";
    };

    "pulseaudio" = {
    	format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click= "pavucontrol";
    };
			};
		};
	}; 
}
