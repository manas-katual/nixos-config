{ userSettings, lib, config, ... }:

{
	 home-manager.users.${userSettings.username} = {
		 home.file.".config/rofi/config.rasi".text = if (userSettings.rofi == "default") 
		 then ''
		   configuration {
				 modi: "drun,run";
				 lines: 5;
				 font: "JetBrains Mono Nerd Font Bold 14";
				 show-icons: true;
				 icon-theme: "Papirus-Dark";
				 terminal: "alacritty";
				 drun-display-format: "{icon} {name}";
				 location: 0;
				 disable-history: false;
				 hide-scrollbar: true;
				 sidebar-mode: true;
				 display-drun: "   Apps ";
				 display-run: "   Command ";
				 display-window: " 﩯  Window ";
			 }

			 @theme "./theme.rasi"

			 element-text, element-icon , mode-switcher {
				 background-color: inherit;
				 text-color:       inherit;
			 }

				window {
					height: 400px;
					width: 600px;
					border: 0px;
					border-radius: 5px;
					border-color: @border-col;
					background-color: @bg-col;
					padding: 0px 0px 0px 0px;
					fullscreen: false;
				}

				mainbox {
						background-color: @bg-col;
				}

				inputbar {
						children: [prompt,entry];
						background-color: @bg-col;
						border-radius: 3px;
						padding: 2px;
				}

				prompt {
						background-color: @bubble;
						padding: 12px;
						text-color: @bg-col;
						border-radius: 3px;
						margin: 8px 0px 0px 8px;
				}

				textbox-prompt-colon {
						expand: false;
						str: ":";
				}

				entry {
						padding: 6px;
						margin: 14px 0px 0px 2.5px;
						text-color: @fg-col;
						background-color: @bg-col;
				}

				listview {
						border: 0px 0px 0px;
						margin: 7px 10px 0px 10px;
						background-color: @bg-col;
						columns: 1;
				}

				element {
						padding: 12px 12px 12px 12px;
						background-color: @bg-col;
						text-color: @fg-col  ;
				}

				element-icon {
						size: 25px;
				}

				element selected {
						background-color:  @selected-col ;
						text-color: @fg-col2  ;
						border-radius: 3px;
				}

				mode-switcher {
						spacing: 0;
					}

				button {
						padding: 12px;
						margin: 10px;
						background-color: @bg-col;
						text-color: @tab;
						vertical-align: 0.5; 
						horizontal-align: 0.5;
				}

				button selected {
					background-color: @bg-col-light;
					text-color: @tab-selected;
					border-radius: 3px;
				}
		 '' 
		 else if (userSettings.rofi == "mac") 
		 then '' 
				configuration{
					modi: ["drun", "window", "run"];
					icon-theme: "Papirus-Dark";
					show-icons: true;
					terminal: "alacritty";
					drun-display-format: "{icon} {name}";
					location: 0;
					disable-history: false;
					sidebar-mode: false;
					display-drun: " ";
					display-run: " ";
					display-window: " ";
					
					//adding vim keybindings
					kb-row-up: "Up,Control+k";
					kb-row-left: "Left,Control+h";
					kb-row-right: "Right,Control+l";
					kb-row-down: "Down,Control+j";

					kb-accept-entry: "Control+z,Control+y,Return,KP_Enter";

					//fixing up
					kb-remove-to-eol: "";
					kb-move-char-back: "Control+b";
					kb-remove-char-back: "BackSpace";
					kb-move-char-forward: "Control+f";
					kb-mode-complete: "Control+o";
				}

				@theme "./theme.rasi"
				'' 
				else '' '';

				###############	Style #############

			 	home.file.".config/rofi/theme.rasi".text = if (userSettings.rofi == "default") 
				then ''
					* {
							bg-col: #'' + config.lib.stylix.colors.base00 + ''; 
							bg-col-light: #'' + config.lib.stylix.colors.base0B + '';
							border-col: #'' + config.lib.stylix.colors.base0B + '';
							selected-col: #'' + config.lib.stylix.colors.base0B + '';
							tab: #'' + config.lib.stylix.colors.base0B + '';
							tab-selected: #'' + config.lib.stylix.colors.base00 + '';
							fg-col: #'' + config.lib.stylix.colors.base05 + '';
							fg-col2: #'' + config.lib.stylix.colors.base00 + '';
							bubble: #'' + config.lib.stylix.colors.base0B + '';
							width: 600;
						}
					 '' else if (userSettings.rofi == "mac") 
					 then '' 
							* {
								font:   "Montserrat 12";

								bg0:    #'' + config.lib.stylix.colors.base00 + '';
								bg1:    #'' + config.lib.stylix.colors.base01 + '';
								bg2:    #'' + config.lib.stylix.colors.base02 + '';

								fg0:    #'' + config.lib.stylix.colors.base03 + '';
								fg1:    #'' + config.lib.stylix.colors.base04 + '';
								fg2:    #'' + config.lib.stylix.colors.base05 + '';

								background-color:   transparent;
								text-color:         @fg0;

								margin:     0;
								padding:    0;
								spacing:    0;
							}

							window {
									background-color:   @bg0;

									location:       center;
									width:          640;
									border-radius:  8;
							}

							inputbar {
									font:       "Montserrat 20";
									padding:    12px;
									spacing:    12px;
									children:   [ icon-search, entry ];
							}

							icon-search {
									expand:     false;
									filename:   "search";
									size: 28px;
							}

							icon-search, entry, element-icon, element-text {
									vertical-align: 0.5;
							}

							entry {
									font:   inherit;

									placeholder         : "Search";
									placeholder-color   : @fg2;
							}

							message {
									border:             2px 0 0;
									border-color:       @bg1;
									background-color:   @bg1;
							}

							textbox {
									padding:    8px 24px;
							}

							listview {
									lines:      10;
									columns:    1;

									fixed-height:   false;
									border:         1px 0 0;
									border-color:   @bg1;
							}

							element {
									padding:            8px 16px;
									spacing:            16px;
									background-color:   transparent;
							}

							element normal active {
									text-color: @bg2;
							}

							element selected normal, element selected active {
									background-color:   @bg2;
									text-color:         @fg1;
							}

							element-icon {
									size:   1em;
							}

							element-text {
									text-color: inherit;
							}

							'' else '' '';
		};
}
