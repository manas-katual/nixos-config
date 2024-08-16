{ userSettings, lib, config, ... }:

{
	 home-manager.users.${userSettings.username} = {
		 home.file.".config/rofi/config.rasi".text = ''
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
		 '';

		 home.file.".config/rofi/theme.rasi".text = ''

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
		 '';
	};
}
