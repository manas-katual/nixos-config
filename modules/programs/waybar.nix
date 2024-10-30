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
          @define-color foreground #''+config.lib.stylix.colors.base07+'';      
          @define-color background #''+config.lib.stylix.colors.base00+'';      
          @define-color alt_background #''+config.lib.stylix.colors.base01+'';  
          @define-color accent #''+config.lib.stylix.colors.base0A+'';          

          @define-color black #''+config.lib.stylix.colors.base01+'';           
          @define-color red #''+config.lib.stylix.colors.base09+'';             
          @define-color green #''+config.lib.stylix.colors.base0B+'';           
          @define-color yellow #''+config.lib.stylix.colors.base0A+'';          
          @define-color blue #''+config.lib.stylix.colors.base0C+'';            
          @define-color magenta #''+config.lib.stylix.colors.base0D+'';         
          @define-color cyan #''+config.lib.stylix.colors.base0A+'';            
          @define-color white #''+config.lib.stylix.colors.base05+'';           

          @define-color alt_black #''+config.lib.stylix.colors.base02+'';       
          @define-color alt_red #''+config.lib.stylix.colors.base08+'';         
          @define-color alt_green #''+config.lib.stylix.colors.base0B+'';       
          @define-color alt_yellow #''+config.lib.stylix.colors.base0A+'';      
          @define-color alt_blue #''+config.lib.stylix.colors.base0C+'';        
          @define-color alt_magenta #''+config.lib.stylix.colors.base0D+'';     
          @define-color alt_cyan #''+config.lib.stylix.colors.base0E+'';        
          @define-color alt_white #''+config.lib.stylix.colors.base07+'';       

        /* style.css */

            * {

                border: none;
                font-family: JetBrainsMono Nerd Font, sans-serif;
                font-size: 14px;
            }

            window#waybar {
                /* background-color: rgba(18, 21, 29, 0.98); */
                background-color: @background;
                /* background-color: rgba(0, 0, 0, 0); */
                /* border-radius: 6px; */
                color: @foreground;
                opacity: 0.95;
                transition-property: background-color;
                transition-duration: .5s;
                margin-bottom: -7px;
            }

            window#waybar.hidden {
                opacity: 0.2;
            }

            window#sway-window {
                background-color: @background;
            }

            #workspaces,
            #mode,
            #window,
            #cpu,
            #memory,
            #temperature,
            #custom-media,
            #custom-powermenu,
            #custom-fans,
            #custom-wmname,
            #clock,
            #idle_inhibitor,
            #bluetooth,
            #language,
            #pulseaudio,
            #backlight,
            #battery,
            #network,
            #tray,
            #custom-notification {
                background-color: @alt_background;
                padding: 0 10px;
                margin: 5px 2px 5px 2px;
                border: 1px solid rgba(0, 0, 0, 0);
                border-radius: 6px;
                background-clip: padding-box;
            }

            #workspaces button {
                background-color: @alt_background;
                padding: 0 5px;
                min-width: 20px;
                color: @foreground;
            }

            #workspaces button:hover {
                background-color: rgba(0, 0, 0, 0)
            }

            #workspaces button.active {
                color: @accent;
            }

            #workspaces button.urgent {
                color: @red;
            }

            #cpu {
                padding: 0 10px;
                color: @alt_cyan;
            }

            #memory {
                padding: 0 10px;
                color: @alt_cyan;
            }

            #temperature {
                padding: 0 10px;
                color: @blue;
            }

            #temperature.critical {
                background-color: @red;
                padding: 0 10px;
                color: @background;
            }

            #custom-media {
                color: #c678dd;
                padding: 0 10px;
                color: @background;
            }

            #custom-fans {
                padding: 0 10px;
                color: @blue;
            }

            #bluetooth {
                padding: 0 10px;
                color: @blue;
            }

            #clock {
                padding: 0 10px;
                color: @blue;
            }

            #idle_inhibitor {
                padding: 0 10px;
                color: @foreground;
            }

            #language {
                padding: 0 10px;
                color: @blue;
            }

            #pulseaudio {
                padding: 0 10px;
                color: @yellow;
            }

            #pulseaudio.muted {
                padding: 0 10px;
                background-color: @red;
                color: @background;
            }

            #backlight {
                padding: 0 10px;
                color: @yellow;
            }

            #battery {
                padding: 0 10px;
                color: @alt_green;
            }

            #battery.charging, #battery.plugged {
                padding: 0 10px;
                background-color: @alt_green;
                color: @background;
            }

            @keyframes blink {
                to {
                    background-color: @background;
                    color: @red;
                }
            }

            #battery.critical:not(.charging) {
                padding: 0 10px;
                background-color: @red;
                color: @background;
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
            }

            #network {
                padding: 0 10px;
                color: @blue;
            }

            #custom-wmname {
                color: @accent;
                background-color: @background;
                font-size: 25px;
                margin: 1px;
                padding: 0px 0px 0px 5px;
            }

            #network.disconnected {
                padding: 0 10px;
                background-color: @red;
                color: @background;
            }
            #custom-powermenu {
                background-color: @red;
                color: @background;
                font-size: 15px;
                padding-right: 6px;
                padding-left: 11px;
                margin: 5px;
            }

            #custom-notification {
                padding: 0 10px;
                color: @accent;
            }
        '';

        # config.json
        settings = {
            mainBar = {
            margin = "7 7 3 7";
            layer = "top";
            height = 35;
            modules-left = ["custom/wmname" "sway/workspaces" "backlight" "memory" "bluetooth" "idle_inhibitor"];
            modules-center = ["clock"];
            modules-right = ["network" "battery" "cpu" "pulseaudio" "custom/notification" "tray" "custom/powermenu"];

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
                format = " {:%H:%M}";
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
                on-scroll-down = "${pkgs.light}/bin/light -U 5";
                on-scroll-up = "${pkgs.light}/bin/light -A 5";
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
                format-alt = "bluetooth= {status}";
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
                format-bluetooth = " {icon} {volume}%";
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
                    default = [" " " " " "];
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
                format = " ";
                on-click = "${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
                on-click-release = "sleep 1";
            };
            };
        };
        };
    };
  };
}

