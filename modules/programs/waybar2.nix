{ pkgs, config, lib, userSettings, inputs, ... }:

{

  config = lib.mkIf (config.wlwm.enable) {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    home-manager.users.${userSettings.username} = {
        programs.waybar = {
        enable = true;
        style = '' 
          /* base16 */
@define-color bg_dim #232a2e;
@define-color bg0 #2d353b;
@define-color bg1 #343f44;
@define-color bg2 #3d484d;
@define-color bg3 #475258;
@define-color bg4 #4f585e;
@define-color bg5 #56635f;
@define-color bg_visual #543a48;
@define-color bg_red #514045;
@define-color bg_green #425047;
@define-color bg_blue #3a515d;
@define-color bg_yellow #4d4c43;
@define-color fg #d3c6aa;
@define-color red #e67e80;
@define-color orange #e69875;
@define-color yellow #dbbc7f;
@define-color green #a7c080;
@define-color aqua #83c092;
@define-color blue #7fbbb3;
@define-color purple #d699b6;
@define-color grey0 #7a8478;
@define-color grey1 #859289;
@define-color grey2 #9da9a0;
        /* style.css */
	* {
  font-family: JetBrainsMono Nerd Font, FontAwesome;
  font-size: 16px;
  font-weight: bold;
}

window#waybar {
  background-color: @fg;
  color: @bg0;
  transition-property: background-color;
  transition-duration: 0.5s;
  border-radius: 0px 0px 15px 15px;
  transition-duration: .5s;

  border-bottom-width: 5px;
  border-bottom-color: #7d6a40;
  border-bottom-style: solid;
}

#custom-wmname,
#clock,
#clock-date,
#workspaces,
#pulseaudio,
#network,
#battery,
#custom-powermenu {
  background-color: @bg0;
  color: @fg;

  padding-left: 10px;
  padding-right: 10px;
  margin-top: 7px;
  margin-bottom: 12px;
	border-radius: 10px;

  border-bottom-width: 5px;
  border-bottom-color: #161a1d;
  border-bottom-style: solid;
}

#workspaces {
  padding: 0px;
}

#workspaces button.active {
  background-color: @blue;
  color: @bg0;

	border-radius: 10px;

  margin-bottom: -5px;

  border-bottom-width: 5px;
  border-bottom-color: #366660;
  border-bottom-style: solid;
}

#custom-wmname {
  background-color: @green;
  color: @bg0;
  border-bottom-color: #556a35;

  margin-left: 15px;
  padding-left: 20px;
  padding-right: 21px;
}

#custom-powermenu {
  background-color: @red;
  color: @bg0;
  border-bottom-color: #951c1f;

  margin-right: 15px;
  padding-left: 20px;
  padding-right: 23px;
}
        '';

        # config.json
        settings = {
            mainBar = {
            margin = "7 120 3 120";
            layer = "top";
            height = 60;
	    spacing = 15;
            modules-left = ["custom/wmname" "clock"];
            modules-center = ["sway/workspaces"];
            modules-right = ["pulseaudio" "network" "battery" "custom/powermenu"];

            /* Modules configuration */
            "sway/workspaces" = {
              format = "<span font='11'>{icon}</span>";
              format-icons = {
                # "1"="";
                # "2"="";
                # "3"="";
                # "4"="";
                # "5"="";
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
              };
              all-outputs = true;
              persistent_workspaces = {
                # "1" = [];
                # "2" = [];
                # "3" = [];
                # "4" = [];
                # "5" = [];
                "1" = [ ];
                "2" = [ ];
                "3" = [ ];
                "4" = [ ];
                "5" = [ ];
                "6" = [ ];
                "7" = [ ];
                "8" = [ ];
              };
            };
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };

            "idle_inhibitor"= {
                "format"= "{icon}";
                "format-icons"= {
                "activated"= "󰅶";
                "deactivated"= "󰾪";
                };
            };

            "tray" = {
                spacing = 8;
            };

            "clock" = {
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                format = "󱑏 {:%H:%M}";
                format-alt = " {:%A, %B %d, %Y}";
            };

            "cpu" = {
                format = " {usage}%";
                tooltip = "false";
            };

            "memory" = {
                format = " {}%";
            };

            "backlight" = {
                format = "{icon}{percent}%";
                format-icons = ["󰃞 " "󰃟 " "󰃠 "];
                #on-scroll-down = "${pkgs.light}/bin/light -U 5";
                #on-scroll-up = "${pkgs.light}/bin/light -A 5";
            };

            "battery" = {
                states = {
                warning = "30";
                critical = "15";
            };
                format = "{icon}{capacity}%";
                tooltip-format = "{timeTo} {capacity}%";
                format-charging = "󱐋 {capacity}%";
                format-plugged = " ";
                format-alt = "{time} {icon}";
                format-icons = ["  " "  " "  " "  " "  "];
            };

            "network" = {
                format-wifi = "󰒢 ";
                format-ethernet = "{ifname}: {ipaddr}/{cidr}  ";
                format-linked = "{ifname} (No IP)  ";
                format-disconnected = "󰞃 ";
                on-click = "kitty nmtui";
                on-click-release = "sleep 0";
                tooltip-format = "{essid} {signalStrength}%";
            };

            "bluetooth"= {
		device = "intel_backlight";
                format = "{icon}";
                format-alt = "{status}";
                interval = 30;
                on-click-right = "${pkgs.blueberry}/bin/blueberry";
                "format-icons" = {
                  enabled = "";
                  disabled = "󰂲";  
                };
                tooltip-format = "{status}";
            };

            "pulseaudio" = {
                format = "{icon}{volume}% {format_source}";
                format-bluetooth = "{icon} {volume}%";
                format-bluetooth-muted = "   {volume}%";
                format-source = "";
                format-source-muted = "";
                format-muted = "  {format_source}";
                format-icons = {
                    headphone = " ";
                    hands-free = " ";
                    headset = " ";
                    phone = " ";
                    portable = " ";
                    car = " ";
                    default = ["󰕿 " "󰖀 " "󰕾 "];
                };
                tooltip-format = "{desc} {volume}%";
		on-click = "${pkgs.pamixer}/bin/pamixer -t";
                on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
                on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
                on-click-middle-release = "sleep 0";
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
       #on-click = "sleep 0.1 && task-waybar";
       on-click = "sleep 0.1; swaync-client -t -sw";
       on-click-right = "sleep 0.1; swaync-client -d -sw";
       escape = true;
    };

            "custom/wmname" = {
                format = " ";
                on-click = "${pkgs.wofi}/bin/wofi --show drun --allow-images --sort-order=alphabetical";
                on-click-release = "sleep 0";
            };

            "custom/powermenu" = {
                format = "⏻ ";
                on-click = "${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
                on-click-release = "sleep 1";
            };
            };
        };
        };
    };
  };
}

