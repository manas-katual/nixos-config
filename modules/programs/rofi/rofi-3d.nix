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

element-text, element-icon, mode-switcher {
    background-color: inherit;
    text-color: inherit;
}

window {
    height: 400px;
    width: 600px;
    border: 0px;
    border-radius: 10px;  /* Increased border-radius for a smoother 3D effect */
    border-color: @border-col;
    background-color: @bg-col;
    padding: 0px 0px 0px 0px;
    fullscreen: false;
    box-shadow: 0px 4px 8px #00000033;  /* Shadow for 3D effect */
}

mainbox {
    background-color: @bg-col;
}

inputbar {
    children: [prompt, entry];
    background-color: @bg-col;
    border-radius: 5px;  /* Adjusted for a smoother 3D effect */
    padding: 2px;
    box-shadow: inset 0px 1px 3px #0000001a;  /* Inner shadow for depth */
}

prompt {
    background-color: @bubble;
    padding: 12px;
    text-color: @bg-col;
    border-radius: 5px;  /* Adjusted for a smoother 3D effect */
    margin: 8px 0px 0px 8px;
    box-shadow: 0px 1px 2px #00000033;  /* Shadow for a lifted look */
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
    border-radius: 5px;  /* Rounded corners for a more 3D effect */
    box-shadow: inset 0px 1px 2px #0000001a;  /* Inner shadow for depth */
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
    text-color: @fg-col;
    border-radius: 5px;  /* Rounded corners for a more 3D effect */
    box-shadow: 0px 2px 4px #00000033;  /* Shadow for a lifted look */
}

element-icon {
    size: 25px;
}

element selected {
    background-color: @selected-col;
    text-color: @fg-col2;
    border-radius: 5px;  /* Rounded corners for a more 3D effect */
    box-shadow: 0px 2px 6px #00000033;  /* Shadow to highlight selection */
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
    border-radius: 5px;  /* Rounded corners for a more 3D effect */
    box-shadow: 0px 2px 4px #00000033;  /* Shadow for a lifted look */
}

button selected {
    background-color: @bg-col-light;
    box-shadow: 0px 4px 8px #00000033;  /* Enhanced shadow for selection */
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
