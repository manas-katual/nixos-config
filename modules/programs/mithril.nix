{
  pkgs,
  inputs,
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "mithril") {
    home-manager.users.${userSettings.username} = {
      imports = [
        inputs.mithril-shell.homeManagerModules.default
      ];

      services.mithril-shell.enable = true;
      services.mithril-shell.integrations.hyprland.enable = true;
      services.mithril-shell.settings.lockCommand = "${pkgs.hyprlock}/bin/hyprlock --immediate";
      services.mithril-shell.settings.bar.modules.workspacesIndicator.reverseScrollDirection = true;
      programs.mithril-control-center.enable = true;
      programs.mithril-control-center.package = inputs.mithril-shell.packages.${pkgs.system}.mithril-control-center;
      programs.mithril-control-center.compatibility.enable = true;
      programs.mithril-control-center.compatibility.bluetooth.enable = true;
      services.mithril-shell.settings.popups.volumePopup.enable = true;
    };
  };
}
