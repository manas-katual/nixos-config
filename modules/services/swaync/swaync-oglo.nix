{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: let
  colors = import ../../theming/colors.nix;
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-oglo") {
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
    ];

    home-manager.users.${userSettings.username} = {
      xdg.configFile = {
        "swaync/style.css".text = with colors.scheme.${userSettings.theme}; ''

          @define-color noti-bg-focus rgba(0, 0, 0, 0);
          @define-color sep-color transparent;

          * {
            all: unset;
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 20px;
          }

          .notification-row {
            outline: none;
          }

          .notification-row:focus,
          .notification-row:hover {
            background: @noti-bg-focus;
          }

          .notification {
            border-radius: 10px;
            margin: 6px 12px;
            box-shadow: none;
            padding: 0;
            min-height: 100px;
          }

          .notification label {
            padding-left: 10px;
          }

          .low,
          .normal {
            background-color: #${noti-border-color};
            padding: 4px 4px 4px 4px;
            border: none;
            border-radius: 10px;
          }

          .critical {
            background-color: #${noti-border-color-critical};
            padding: 4px 4px 4px 4px;
            border: none;
            border-radius: 10px;
          }

          .notification-content {
            background: transparent;
            padding: 10px;
            border-radius: 10px;
          }

          .close-button {
            background: #${noti-close-bg};
            color: #${foreground};
            text-shadow: none;
            padding: 0;
            border-radius: 100%;
            margin-top: 12px;
            margin-right: 16px;
            box-shadow: none;
            border: none;
            min-width: 24px;
            min-height: 24px;
          }

          .close-button:hover {
            box-shadow: none;
            background: #${noti-close-bg-hover};
            transition: all 0.15s ease-in-out;
            border: none;
          }

          .notification-default-action {
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background-color: #${noti-bg};
            border: none;
            border-bottom: 1px solid @sep-color;
            color: #${foreground};
            transition: all 0.15s ease-in-out;
          }

          .notification-action {
            border: none;
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background-color: #${noti-button};
            color: #${foreground};
            transition: all 0.15s ease-in-out;
          }

          .notification-default-action:hover {
            -gtk-icon-effect: none;
            background: #${noti-bg-hover};
          }

          .notification-action:hover {
            -gtk-icon-effect: none;
            background: #${noti-button-hover};
          }

          .notification-default-action {
            border-radius: 8px;
          }

          /* When alternative actions are visible */
          .notification-default-action:not(:only-child) {
            border-bottom-left-radius: 0px;
            border-bottom-right-radius: 0px;
          }

          .notification-action {
            border-radius: 0px;
            border-top: none;
            border-right: none;
          }

          /* add bottom border radius to eliminate clipping */
          .notification-action:first-child {
            border-bottom-left-radius: 10px;
          }

          .notification-action:last-child {
            border-bottom-right-radius: 10px;
            border-right: 1px solid #${noti-border-color};
          }

          .inline-reply {
            margin-top: 8px;
          }
          .inline-reply-entry {
            background: #${noti-bg-darker};
            color: #${foreground};
            caret-color: #${foreground};
            border: 1px solid #${noti-border-color};
            border-radius: 12px;
          }
          .inline-reply-button {
            margin-left: 4px;
            background: #${noti-bg};
            border: 1px solid #${noti-border-color};
            border-radius: 12px;
            color: #${foreground};
          }
          .inline-reply-button:disabled {
            background: initial;
            color: #${foreground-disabled};
            border: 1px solid transparent;
          }
          .inline-reply-button:hover {
            background: #${noti-bg-hover};
          }

          .image {
          }

          .body-image {
            margin-top: 6px;
            background-color: white;
            border-radius: 12px;
          }

          .summary {
            font-size: 22px;
            font-weight: bold;
            background: transparent;
            color: #${foreground};
            text-shadow: none;
          }

          .time {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: #${foreground};
            text-shadow: none;
            margin-right: 18px;
          }

          .body {
            font-size: 18px;
            font-weight: normal;
            background: transparent;
            color: #${foreground};
            text-shadow: none;
          }

          .control-center {
            background: #${cc-bg};
            padding-bottom: 25px;
            padding-top: 5px;
            padding-left: 10px;
            padding-right: 9px;
          }

          .control-center-list {
            background: transparent;
          }

          .control-center-list-placeholder {
            opacity: 0.5;
          }

          .floating-notifications {
            background: transparent;
          }

          /* Window behind control center and on all other monitors */
          .blank-window {
            background-color: transparent;
          }

          /*** Widgets ***/

          /* Title widget */
          .widget-title {
            margin: 8px;
            font-size: 1.5rem;
            font-weight: bold;
            color: #${foreground};
          }
          .widget-title > button {
            font-size: 20px;
            font-weight: bold;
            color: #${button-foreground};
            text-shadow: none;
            background-color: #${button};
            border: none;
            border-bottom: 8px solid #${button-bottom};
            box-shadow: none;
            border-radius: 5px;
            padding-left: 15px;
            padding-right: 15px;
            padding-top: 5px;
            padding-bottom: 5px;
          }
          .widget-title > button:hover {
            background-color: #${button-hover};
            border-bottom: 8px solid #${button-bottom-hover};
          }

          /* DND widget */
          .widget-dnd {
            margin: 8px;
            font-size: 1.1rem;
            color: #${foreground};
          }
          .widget-dnd > switch {
            font-size: initial;
            border-radius: 100px;
            background: #${dnd-bg};
            border: none;
            box-shadow: none;
            color: transparent;
            margin: 0px;
          }
          .widget-dnd > switch:checked {
            background: #${dnd-selected};
          }
          .widget-dnd > switch slider {
            background: #${dnd-dot};
            border-radius: 100px;
            padding-top: 0px;
            padding-bottom: 0px;
            min-height: 28px;
            min-width: 30px;
            margin: 0px;
          }

          /* Label widget */
          .widget-label {
            margin: 8px;
          }
          .widget-label > label {
            font-size: 1.1rem;
          }

          /* Mpris widget */
          .widget-mpris {
            /* The parent to all players */
          }
          .widget-mpris-player {
            padding: 8px;
            margin: 8px;
          }
          .widget-mpris-title {
            font-weight: bold;
            font-size: 1.25rem;
          }
          .widget-mpris-subtitle {
            font-size: 1.1rem;
          }

          /* Buttons widget */
          .widget-buttons-grid {
            padding: 8px;
            margin: 8px;
            border-radius: 12px;
            background-color: #${noti-bg};
          }

          .widget-buttons-grid>flowbox>flowboxchild>button{
            background: #${noti-bg};
            border-radius: 12px;
          }

          .widget-buttons-grid>flowbox>flowboxchild>button:hover {
            background: #${noti-bg-hover};
          }

          /* Menubar widget */
          .widget-menubar>box>.menu-button-bar>button {
            border: none;
            background: transparent;
          }

          .AnyName {
            background-color: #${noti-bg};
            padding: 8px;
            margin: 8px;
            border-radius: 10px;
          }

          .AnyName>button {
            background-color: transparent;
            border: none;
          }

          .AnyName>button:hover {
            background-color: #${noti-bg-hover};
          }

          .topbar-buttons>button { /* Name defined in config after # */
            border: none;
            background: transparent;
          }

          /* Volume widget */

          .widget-volume {
            background-color: #${noti-bg};
            padding: 8px;
            margin: 8px;
            border-radius: 12px;
          }

          .widget-volume>box>button {
            background: transparent;
            border: none;
          }

          .per-app-volume {
            background-color: @noti-bg-alt;
            padding: 4px 8px 8px 8px;
            margin: 0px 8px 8px 8px;
            border-radius: 12px
          }

          /* Backlight widget */
          .widget-backlight {
            background-color: #${noti-bg};
            padding: 8px;
            margin: 8px;
            border-radius: 12px;
          }

          /* Title widget */
          .widget-inhibitors {
            margin: 8px;
            font-size: 1.5rem;
          }
          .widget-inhibitors > button {
            font-size: initial;
            color: @foreground;
            text-shadow: none;
            background: @noti-bg;
            border: 1px solid #${noti-border-color};
            box-shadow: none;
            border-radius: 12px;
          }
          .widget-inhibitors > button:hover {
            background: #${noti-bg-hover};
          }

        '';
      };
    };
  };
}
