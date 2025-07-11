{
  config,
  lib,
  userSettings,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-cool" || userSettings.style == "waybar-curve" || userSettings.style == "waybar-ddubs" || userSettings.style == "waybar-dwm" || userSettings.style == "waybar-jake" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-macos" || userSettings.style == "waybar-nekodyke" || userSettings.style == "waybar-simple") {
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
    ];
    home-manager.users.${userSettings.username} = {
      xdg.configFile = {
        "swaync/style.css".text = ''

          * {
              all: unset;
              font-size: 16px;
              font-family: "Caskaydia Cove Nerd Font";
              transition: 200ms;
            }

            trough highlight {
              background: #${config.lib.stylix.colors.base0B};
            }

            scale trough {
              margin: 0rem 1rem;
              background-color: #${config.lib.stylix.colors.base01};
              min-height: 8px;
              min-width: 70px;
            }

            slider {
              background-color: #${config.lib.stylix.colors.base0B};
            }

            .floating-notifications.background .notification-row .notification-background {
              box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${config.lib.stylix.colors.base01};
              border-radius: 12.6px;
              margin: 18px;
              background-color: #${config.lib.stylix.colors.base00};
              color: #${config.lib.stylix.colors.base05};
              padding: 0;
            }

            .floating-notifications.background .notification-row .notification-background .notification {
              padding: 7px;
              border-radius: 12.6px;
            }

            .floating-notifications.background .notification-row .notification-background .notification.critical {
              border: 2pt solid #${config.lib.stylix.colors.base09};
            }

            .floating-notifications.background .notification-row .notification-background .notification .notification-content {
              margin: 7px;
            }

            .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
              font-size: 18px;
              font-weight: bold;
              color: #${config.lib.stylix.colors.base05};
              margin-bottom: 5px;
            }

            .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
              color: #${config.lib.stylix.colors.base03};
            }

            .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
              color: #${config.lib.stylix.colors.base07};
            }

            .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
              min-height: 3.4em;
            }

            .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
              border-radius: 7px;
              color: #${config.lib.stylix.colors.base05};
              background-color: #${config.lib.stylix.colors.base00};
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              margin: 7px;
            }

            .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base01};
              color: #${config.lib.stylix.colors.base05};
            }

            .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base0B};
              color: #${config.lib.stylix.colors.base05};
            }

            .floating-notifications.background .notification-row .notification-background .close-button {
              margin: 7px;
              padding: 2px;
              border-radius: 6.3px;
              color: #${config.lib.stylix.colors.base00};
              background-color: #${config.lib.stylix.colors.base09};
            }

            .floating-notifications.background .notification-row .notification-background .close-button:hover {
              background-color: #${config.lib.stylix.colors.base08};
              color: #${config.lib.stylix.colors.base00};
            }

            .floating-notifications.background .notification-row .notification-background .close-button:active {
              background-color: #${config.lib.stylix.colors.base09};
              color: #${config.lib.stylix.colors.base00};
            }

            .control-center {
              box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${config.lib.stylix.colors.base01};
              border-radius: 12.6px;
              margin: 18px;
              background-color: #${config.lib.stylix.colors.base00};
              color: #${config.lib.stylix.colors.base05};
              padding: 14px;
            }

            .control-center .widget-title > label {
              color: #${config.lib.stylix.colors.base05};
              font-size: 1.3em;
            }

            .control-center .widget-title button {
              border-radius: 7px;
              color: #${config.lib.stylix.colors.base05};
              background-color: #${config.lib.stylix.colors.base01};
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              padding: 8px;
            }

            .control-center .widget-title button:hover {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base02};
              color: #${config.lib.stylix.colors.base05};
            }

            .control-center .widget-title button:active {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base0B};
              color: #${config.lib.stylix.colors.base00};
            }

            .control-center .notification-row .notification-background {
              border-radius: 7px;
              color: #${config.lib.stylix.colors.base05};
              background-color: #${config.lib.stylix.colors.base01};
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              margin-top: 14px;
            }

            .control-center .notification-row .notification-background .notification {
              padding: 7px;
              border-radius: 7px;
            }

            .control-center .notification-row .notification-background .notification.critical {
              border: 2pt solid #${config.lib.stylix.colors.base09};
            }

            .control-center .notification-row .notification-background .notification .notification-content {
              margin: 7px;
            }

            .control-center .notification-row .notification-background .notification .notification-content .summary {
              color: #${config.lib.stylix.colors.base05};
              font-size: 18px;
              font-weight: bold;
            }

            .control-center .notification-row .notification-background .notification .notification-content .time {
              color: #${config.lib.stylix.colors.base03};
            }

            .control-center .notification-row .notification-background .notification .notification-content .body {
              color: #${config.lib.stylix.colors.base05};
            }

            .control-center .notification-row .notification-background .notification > *:last-child > * {
              min-height: 3.4em;
            }

            .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
              border-radius: 7px;
              color: #${config.lib.stylix.colors.base05};
              background-color: #${config.lib.stylix.colors.base00};
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              margin: 7px;
            }

            .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base01};
              color: #${config.lib.stylix.colors.base05};
            }

            .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base0B};
              color: #${config.lib.stylix.colors.base05};
            }

            .control-center .notification-row .notification-background .close-button {
              margin: 7px;
              padding: 2px;
              border-radius: 6.3px;
              color: #${config.lib.stylix.colors.base00};
              background-color: #${config.lib.stylix.colors.base08};
            }

            .close-button {
              border-radius: 6.3px;
            }

            .control-center .notification-row .notification-background .close-button:hover {
              background-color: #${config.lib.stylix.colors.base09};
              color: #${config.lib.stylix.colors.base00};
            }

            .control-center .notification-row .notification-background .close-button:active {
              background-color: #${config.lib.stylix.colors.base09};
              color: #${config.lib.stylix.colors.base00};
            }

            .control-center .notification-row .notification-background:hover {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base02};
              color: #${config.lib.stylix.colors.base05};
            }

            .control-center .notification-row .notification-background:active {
              box-shadow: inset 0 0 0 1px #${config.lib.stylix.colors.base02};
              background-color: #${config.lib.stylix.colors.base0B};
              color: #${config.lib.stylix.colors.base05};
            }

            .notification.critical progress {
              background-color: #${config.lib.stylix.colors.base09};
            }

            .notification.low progress,
            .notification.normal progress {
              background-color: #${config.lib.stylix.colors.base0B};
            }

            .control-center-dnd {
              margin-top: 5px;
              border-radius: 8px;
              background: #${config.lib.stylix.colors.base01};
              border: 1px solid #${config.lib.stylix.colors.base02};
              box-shadow: none;
            }

            .control-center-dnd:checked {
              background: #${config.lib.stylix.colors.base01};
            }

            .control-center-dnd slider {
              background: #${config.lib.stylix.colors.base02};
              border-radius: 8px;
            }

            .widget-dnd {
              margin: 0px;
              font-size: 1.1rem;
            }

            .widget-dnd > switch {
              font-size: initial;
              border-radius: 8px;
              background: #${config.lib.stylix.colors.base01};
              border: 1px solid #${config.lib.stylix.colors.base02};
              box-shadow: none;
            }

            .widget-dnd > switch:checked {
              background: #${config.lib.stylix.colors.base01};
            }

            .widget-dnd > switch slider {
              background: #${config.lib.stylix.colors.base02};
              border-radius: 8px;
              border: 1px solid #${config.lib.stylix.colors.base03};
            }

            .widget-mpris .widget-mpris-player {
              background: #${config.lib.stylix.colors.base01};
              padding: 7px;
            }

            .widget-mpris .widget-mpris-title {
              font-size: 1.2rem;
            }

            .widget-mpris .widget-mpris-subtitle {
              font-size: 0.8rem;
            }

            .widget-menubar > box > .menu-button-bar > button > label {
              font-size: 3rem;
              padding: 0.5rem 2rem;
            }

            .widget-menubar > box > .menu-button-bar > :last-child {
              color: #${config.lib.stylix.colors.base09};
            }

            .power-buttons button:hover,
            .powermode-buttons button:hover,
            .screenshot-buttons button:hover {
              background: #${config.lib.stylix.colors.base01};
            }

            .control-center .widget-label > label {
              color: #${config.lib.stylix.colors.base05};
              font-size: 2rem;
            }

            .widget-buttons-grid {
              padding-top: 1rem;
            }

            .widget-buttons-grid > flowbox > flowboxchild > button label {
              font-size: 2.5rem;
            }

            .widget-volume {
              padding-top: 1rem;
            }

            .widget-volume label {
              font-size: 1.5rem;
              color: #${config.lib.stylix.colors.base0B};
            }

            .widget-volume trough highlight {
              background: #${config.lib.stylix.colors.base0B};
            }

            .widget-backlight trough highlight {
              background: #${config.lib.stylix.colors.base0A};
            }

            .widget-backlight scale {
              margin-right: 1rem;
            }

            .widget-backlight label {
              font-size: 1.5rem;
              color: #${config.lib.stylix.colors.base0A};
            }

            .widget-backlight .KB {
              padding-bottom: 1rem;
            }

            .image {
              margin-right: 10px;
            }
        '';
      };
    };
  };
}
