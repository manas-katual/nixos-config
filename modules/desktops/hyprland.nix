{ pkgs, lib, config, inputs, options, userSettings, ... }:

{
 
  config = lib.mkIf (config.my.desktop.option == "hyprland") {
	
		# hyprland cachix
  	nix.settings = {
    	substituters = ["https://hyprland.cachix.org"];
    	trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  	};

		# Enable hyprland development
		programs.hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		};
    
		environment.systemPackages = with pkgs; [
			#lxde.lxsession
			lxqt.lxqt-policykit
			slurp
			grim
			brightnessctl
			pamixer
			wl-clipboard
			cliphist
			#nwg-dock-hyprland
			#nwg-drawer
			pyprland
		];

		security.polkit.enable = true;

		home-manager.users.${userSettings.username} = {
			wayland.windowManager.hyprland = {
				enable = true;
				#plugins = [
				#  inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
				#];
				xwayland.enable = true;
				systemd = {
					enable = true;
					variables = ["--all"];
				};
				settings = { };
				extraConfig = ''

					env = AQ_DRM_DEVICES,/dev/dri/card1 
          env = NIXOS_OZONE_WL, 1
          env = NIXPKGS_ALLOW_UNFREE, 1
          env = XDG_CURRENT_DESKTOP, Hyprland
          env = XDG_SESSION_TYPE, wayland
          env = XDG_SESSION_DESKTOP, Hyprland
          #env = GDK_BACKEND, wayland, x11
          env = CLUTTER_BACKEND, wayland
          env = QT_QPA_PLATFORM=wayland;xcb
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          #env = SDL_VIDEODRIVER, x11
          env = MOZ_ENABLE_WAYLAND, 1

				  $mainMod = SUPER
					$terminal = kitty
					$fileManager = nautilus
					$menu = rofi -show drun -show-icons -disable-history
					$browser = firefox
					$lock = hyprlock
					
					#monitor = HDMI-A-1,preferred,auto,1,mirror,LVDS-1
					monitor = HDMI-A-1,1366x768,auto,1,mirror,LVDS-1
					
					exec-once = hyprpaper
					exec-once = waybar
					exec-once = hypridle
					#exec-once = lxsession
					exec-once = lxqt-policykit-agent
					exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
					exec-once = swaync
					exec-once = wl-paste --type text --watch cliphist store
					exec-once = wl-paste --type image --watch cliphist store
					#exec-once = nwg-dock-hyprland -r
					exec-once = pypr
          exec-once = emacs --daemon

					debug {
						disable_logs = false
						enable_stdout_logs = true
					}

					input {
						kb_layout = in
						kb_variant = eng
						kb_options = terminate:ctrl_alt_bksp
						numlock_by_default = true

						follow_mouse = 1

						touchpad {
							natural_scroll = true
						}

						#sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
					}

					general {
						gaps_in = 5
						gaps_out = 5
						border_size = 3
            col.active_border = 0xff'' + config.lib.stylix.colors.base08 + " " + ''0xff'' + config.lib.stylix.colors.base09 + " " + ''0xff'' + config.lib.stylix.colors.base0A + " " + ''0xff'' + config.lib.stylix.colors.base0B + " " + ''0xff'' + config.lib.stylix.colors.base0C + " " + ''0xff'' + config.lib.stylix.colors.base0D + " " + ''0xff'' + config.lib.stylix.colors.base0E + " " + ''0xff'' + config.lib.stylix.colors.base0F + " " + ''270deg

            col.inactive_border = 0xaa'' + config.lib.stylix.colors.base02 + ''

						layout = master

						#no_cursor_warps = false
					}

					decoration {
						rounding = 10
						blur {
							enabled = true
							size = 16
							passes = 2
							vibrancy = 0.5
							new_optimizations = true
						}
						drop_shadow = true
						shadow_range = 4
						shadow_render_power = 3
						col.shadow = 0xaa'' + config.lib.stylix.colors.base01 + ''
						active_opacity = 0.9
						inactive_opacity = 0.8
					}

					bezier = pace,0.46, 1, 0.29, 0.99
					bezier = overshot,0.13,0.99,0.29,1.1
					bezier = md3_decel, 0.05, 0.7, 0.1, 1

					animations {
						enabled = true
						animation = windowsIn,1,6,md3_decel,slide
						animation = windowsOut,1,6,md3_decel,slide
						animation = windowsMove,1,6,md3_decel,slide
						animation = fade,1,10,md3_decel
						animation = workspaces,1,7,md3_decel,slide
						animation = specialWorkspace,1,8,md3_decel,slide
						animation = border,0,3,md3_decel
					}

					dwindle {
						pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
						preserve_split = true # you probably want this
					}

					#master {
					#  new_is_master = true
					#}

					gestures {
						workspace_swipe = true
						workspace_swipe_fingers = 3
						workspace_swipe_invert = false
						workspace_swipe_distance = 200
						workspace_swipe_forever = true
					}

					misc {
						animate_manual_resizes = true
						animate_mouse_windowdragging = true
						enable_swallow = true
						render_ahead_of_time = false
						disable_hyprland_logo = true
					}

					windowrule = float, ^(imv)$
					windowrule = float, ^(mpv)$
					windowrule = float, ^(eog)$
					windowrulev2 = float, class:(),title:(Authentication Required)
					windowrulev2 = float, class:(kitty),title:(nmtui)
					windowrulev2 = opacity 1.0,class:^(Brave-browser),fullscreen:1
					#windowrulev2 = float, class:(brave),title:(Save File)
					windowrulev2 = opacity 1.0,class:^(firefox),fullscreen:1
					windowrulev2 = float,title:^(Save to Disk)$
					windowrulev2 = size 70% 75%,title:^(Save to Disk)$
					windowrulev2 = center,title:^(Save to Disk)$


					bind =  $mainMod, Return, exec, $terminal
					bind =  $mainMod, Q, killactive,
					bind =  $mainMod, M, exit,
					bind =  $mainMod SHIFT, F, exec, $fileManager
					bind =  $mainMod, E, exec, emacsclient -c
					bind =  $mainMod, V, togglefloating,
					bind =  $mainMod, R, exec, $menu
					bind =  $mainMod, B, exec, $browser
					bind =  $mainMod, P, pseudo, # dwindle
					bind =  $mainMod, T, togglesplit, # dwindle
					bind =  $mainMod, F, fullscreen # dwindle
					bind =  Alt, F4, exec, wlogout -b 2 # wlogout

					# pypr
					bind =  $mainMod, A, exec, pypr toggle term && hyprctl dispatch bringactivetotop
					bind =  $mainMod, I, exec, pypr toggle volume && hyprctl dispatch bringactivetotop

					# waybar
					bind =  $mainMod SHIFT, C, exec, pkill waybar && waybar

					# Move focus with mainMod + arrow keys
					bind =  $mainMod, left,  movefocus, l
					bind =  $mainMod, right, movefocus, r
					bind =  $mainMod, up,    movefocus, u
					bind =  $mainMod, down,  movefocus, d

					# Moving windows
					bind =  $mainMod SHIFT, left,  swapwindow, l
					bind =  $mainMod SHIFT, right, swapwindow, r
					bind =  $mainMod SHIFT, up,    swapwindow, u
					bind =  $mainMod SHIFT, down,  swapwindow, d

					# Window resizing                     X  Y
					bind =  $mainMod CTRL, left,  resizeactive, -60 0
					bind =  $mainMod CTRL, right, resizeactive,  60 0
					bind =  $mainMod CTRL, up,    resizeactive,  0 -60
					bind =  $mainMod CTRL, down,  resizeactive,  0  60

					# Switch workspaces with mainMod + [0-9]
					bind =  $mainMod, 1, workspace, 1
					bind =  $mainMod, 2, workspace, 2
					bind =  $mainMod, 3, workspace, 3
					bind =  $mainMod, 4, workspace, 4
					bind =  $mainMod, 5, workspace, 5
					bind =  $mainMod, 6, workspace, 6
					bind =  $mainMod, 7, workspace, 7
					bind =  $mainMod, 8, workspace, 8
					bind =  $mainMod, 9, workspace, 9
					bind =  $mainMod, 0, workspace, 10

					# Move active window to a workspace with mainMod + SHIFT + [0-9]
					bind =  $mainMod SHIFT, 1, movetoworkspacesilent, 1
					bind =  $mainMod SHIFT, 2, movetoworkspacesilent, 2
					bind =  $mainMod SHIFT, 3, movetoworkspacesilent, 3
					bind =  $mainMod SHIFT, 4, movetoworkspacesilent, 4
					bind =  $mainMod SHIFT, 5, movetoworkspacesilent, 5
					bind =  $mainMod SHIFT, 6, movetoworkspacesilent, 6
					bind =  $mainMod SHIFT, 7, movetoworkspacesilent, 7
					bind =  $mainMod SHIFT, 8, movetoworkspacesilent, 8
					bind =  $mainMod SHIFT, 9, movetoworkspacesilent, 9
					bind =  $mainMod SHIFT, 0, movetoworkspacesilent, 10

					# Scroll through existing workspaces with mainMod + scroll
					bind =  $mainMod, mouse_down, workspace, e-1
					bind =  $mainMod, mouse_up, workspace, e+1

					# brightness control
					bind =  $mainMod, F3, exec, brightnessctl -d *::kbd_backlight set +33%
					bind =  $mainMod, F2, exec, brightnessctl -d *::kbd_backlight set 33%-

					# Volume and Media Control
					bind =  , XF86AudioRaiseVolume, exec, pamixer -i 5 
					bind =  , XF86AudioLowerVolume, exec, pamixer -d 5 
					bind =  , XF86AudioMute, exec, pamixer -t
					bind =  , XF86AudioMicMute, exec, pamixer --default-source -m
						
					# Brightness control
					bind =  , XF86MonBrightnessDown, exec, brightnessctl set 5%- 
					bind =  , XF86MonBrightnessUp, exec, brightnessctl set +5% 

					# Configuration files
					#, Print, exec, grim -g $(slurp) - | swappy -f -
					# Screenshot with selection
					bind =  , Print, exec, grim -g $(slurp) - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send Screenshot of the region taken -t 1000 

					# Whole screen Screenshot
					bind =  SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send Screenshot of whole screen taken -t 1000 

					# current window (pos and size)
					bind =  ALT, Print, exec, grim -g $(hyprctl activewindow | grep at: | cut -d: -f2 | tr -d   | tail -n1) $(hyprctl activewindow | grep size: | cut -d: -f2 | tr -d   | tail -n1 | sed s/,/x/g) - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | notify-send Screenshot of current window taken -t 1000 

					# screenlock
					bind =  $mainMod, L, exec, $lock

					# Move/resize windows with mainMod + LMB/RMB and dragging
					bindm =  $mainMod, mouse:272, movewindow
					bindm =  $mainMod, mouse:273, resizewindow
				 
				 ''; 
			};

			# hyprpaper
			services.hyprpaper = {
				enable = true;
				package = pkgs.hyprpaper;
				settings = {
					ipc = "on";
					splash = false;
				preload = [
				# 	(if (userSettings.theme == "gruvbox-dark-hard") 
        #     then "~/setup/modules/wallpapers/car.jpg" 
				# 	else if (userSettings.theme == "gruvbox-dark-medium") 
        #     then "~/setup/modules/wallpapers/gruvbox-car.jpg" 
        #    else if (userSettings.theme == "solarized-dark") 
        #      then "~/setup/modules/wallpapers/solarized-dark.jpg"
        #    else if (userSettings.theme == "nord") 
        #      then "~/setup/modules/wallpapers/nord_bridge.png"
        #    else if (userSettings.theme == "uwunicorn") 
        #      then "~/setup/modules/wallpapers/pink_house.jpg"
        #    else if (userSettings.theme == "everforest") 
        #      then "~/setup/modules/wallpapers/everforest.png"
        #    else 
				# 	 "~/setup/modules/wallpapers/sky.jpg"
				# 	 )
          ''+config.stylix.image+''
				];

				wallpaper = [
					# (if (userSettings.theme == "gruvbox-dark-hard") 
          #    then "LVDS-1,~/setup/modules/wallpapers/car.jpg" 
					# else if (userSettings.theme == "gruvbox-dark-medium") 
          #    then "LVDS-1,~/setup/modules/wallpapers/gruvbox-car.jpg" 
          #  else if (userSettings.theme == "solarized-dark") 
          #    then "LVDS-1,~/setup/modules/wallpapers/solarized-dark.jpg" 
          #  else if (userSettings.theme == "nord") 
          #    then "LVDS-1,~/setup/modules/wallpapers/nord_bridge.png"
          #  else if (userSettings.theme == "uwunicorn") 
          #    then "LVDS-1,~/setup/modules/wallpapers/pink_house.jpg"
          #  else if (userSettings.theme == "everforest") 
          #    then "LVDS-1,~/setup/modules/wallpapers/everforest.png"
          #  else 
					#  "LVDS-1,~/setup/modules/wallpapers/sky.jpg"
					#  )
          ''+config.stylix.image+''
				];
				};
			};

				# hyprlock
				programs.hyprlock = {
				enable = true;
				package = pkgs.hyprlock;
				extraConfig = ''
					background {
				monitor =
				path = $HOME/setup/modules/wallpapers/hyprland.png   # only png supported for now


				blur_passes = 3 # 0 disables blurring
				blur_size = 7
				noise = 0.0117
				contrast = 0.8916
				brightness = 0.8172
				vibrancy = 0.1696
				vibrancy_darkness = 0.0
		}

		input-field {
				monitor =
				size = 200, 50
				outline_thickness = 3
				dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
				dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
				dots_center = true
				dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
				outer_color = rgb(151515)
				inner_color = rgb(200, 200, 200)
				font_color = rgb(10, 10, 10)
				fade_on_empty = true
				fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
				placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
				hide_input = false
				rounding = -1 # -1 means complete rounding (circle/oval)
				check_color = rgb(204, 136, 34)
				fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
				fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
				fail_transition = 300 # transition time in ms between normal outer_color and fail_color
				capslock_color = -1
				numlock_color = -1
				bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
				invert_numlock = false # change color if numlock is off
				swap_font_color = false # see below
				position = 0, -20
				halign = center
				valign = center
		}

		label {
				monitor =
				text = cmd[update:1000] echo "$TIME"
				color = rgba(200, 200, 200, 1.0)
				font_size = 55
				font_family = Fira Semibold
				position = -100, -200
				halign = right
				valign = bottom
				shadow_passes = 5
				shadow_size = 10
		}

		label {
				monitor =
				text = Manas
				color = rgba(200, 200, 200, 1.0)
				font_size = 20
				font_family = Fira Semibold
				position = -100, 160
				halign = right
				valign = bottom
				shadow_passes = 5
				shadow_size = 10
		}

				'';
			};


			# hypridle
				services.hypridle = {
				enable = true;
				package = pkgs.hypridle;
				settings = {
					general = {
				after_sleep_cmd = "hyprctl dispatch dpms on";
				ignore_dbus_inhibit = false;
				lock_cmd = "hyprlock";
			};

			listener = [
				{
					timeout = 900;
					on-timeout = "hyprlock";
				}
				{
					timeout = 1200;
					on-timeout = "hyprctl dispatch dpms off";
					on-resume = "hyprctl dispatch dpms on";
				}
			];
				};
			};

			# pypr
			

			home.file.".config/hypr/pyprland.toml".text = ''
				[pyprland]
				plugins = [
					"scratchpads"
				]

				[scratchpads.term]
				animation = "fromTop"
				command = "kitty --class kitty-dropterm"
				class = "kitty-dropterm"
				size = "75% 60%"

				#[scratchpads.volume]
				#command = "pavucontrol"
				#margin = 50
				#unfocus = "hide"
				#animation = "fromTop"
				#size = "75% 60%"

				#[scratchpads.bluetooth]
				#animation = "fromTop"
				#command = "blueberry"
				#class = "blueberry.py"
				#size = "75% 60%"
			'';




					
				};
		};
}
