{
  pkgs,
  inputs,
  userSettings,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && (userSettings.style == "hyprpanel" || userSettings.style == "mithril" || userSettings.style == "ags")) {
    environment.systemPackages = [
      inputs.anyrun.packages.${pkgs.system}.anyrun
    ];

    home-manager.users.${userSettings.username} = {
      # imports = [inputs.anyrun.homeManagerModules.default];
      programs.anyrun = {
        enable = true;
        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            shell
            symbols
            translate
          ];

          width.fraction = 0.25;
          y.fraction = 0.3;
          hidePluginInfo = true;
          closeOnClick = true;
        };

        extraCss = ''
          * {
            all: unset;
            font-size: 1.2rem;
          }

          #window,
          #match,
          #entry,
          #plugin,
          #main {
            background: transparent;
          }

          #match.activatable {
            border-radius: 8px;
            margin: 4px 0;
            padding: 4px;
            transition: 100ms ease-out;
          }

          #match.activatable:first-child {
            margin-top: 12px;
          }

          #match.activatable:last-child {
            margin-bottom: 0;
          }

          #match:hover {
            background: rgba(40, 40, 40, 0.9);
          }

          #match:selected {
            background: rgba(60, 60, 60, 0.95);
          }

          #entry {
            background: rgba(30, 30, 30, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            padding: 4px 8px;
          }

          box#main {
            background: rgba(20, 20, 20, 0.95);
            box-shadow:
              inset 0 0 0 1px rgba(255, 255, 255, 0.15),
              0 30px 30px 15px rgba(0, 0, 0, 0.3);
            border-radius: 20px;
            padding: 12px;
          }
        '';

        extraConfigFiles = {
          "applications.ron".text = ''
            Config(
              desktop_actions: false,
              max_entries: 5,
              terminal: Some("ghostty"),
            )
          '';

          "shell.ron".text = ''
            Config(
              prefix: ">"
            )
          '';
        };
      };
    };
  };
}
