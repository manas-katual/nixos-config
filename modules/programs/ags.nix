{
  config,
  pkgs,
  inputs,
  userSettings,
  lib,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "ags") {
    home-manager.users.${userSettings.username} = {
      imports = [inputs.ags.homeManagerModules.default];

      programs.ags = {
        enable = true;

        # symlink to ~/.config/ags
        configDir = ./ags;

        # additional packages to add to gjs's runtime
        extraPackages = with pkgs; [
          gobject-introspection
          polkit

          inputs.ags.packages.${pkgs.system}.battery
          fzf
          # inputs.ags.packages.${pkgs.system}.io
          # inputs.ags.packages.${pkgs.system}.astal3
          inputs.ags.packages.${pkgs.system}.apps
          inputs.ags.packages.${pkgs.system}.auth
          inputs.ags.packages.${pkgs.system}.bluetooth
          inputs.ags.packages.${pkgs.system}.cava
          inputs.ags.packages.${pkgs.system}.greet
          inputs.ags.packages.${pkgs.system}.hyprland
          inputs.ags.packages.${pkgs.system}.mpris
          inputs.ags.packages.${pkgs.system}.network
          inputs.ags.packages.${pkgs.system}.notifd
          inputs.ags.packages.${pkgs.system}.powerprofiles
          inputs.ags.packages.${pkgs.system}.tray
          inputs.ags.packages.${pkgs.system}.wireplumber

          inputs.astal.packages.${pkgs.system}.io
          inputs.astal.packages.${pkgs.system}.astal3
        ];
      };
      home.packages = [inputs.astal.packages.${pkgs.system}.default];

      # home.file.".config/ags".source = ./ags;
    };
  };
}
