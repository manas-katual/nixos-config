{
  config,
  pkgs,
  inputs,
  userSettings,
  lib,
  ...
}: let
  requiredDeps = with pkgs; [
    # config.wayland.windowManager.hyprland.package
    bash
    coreutils
    dart-sass
    gawk
    imagemagick
    inotify-tools
    procps
    ripgrep
    util-linux
  ];

  guiDeps = with pkgs; [
    gnome-control-center
    resources
    overskride
    wlogout
  ];

  dependencies = requiredDeps ++ guiDeps;

  cfg = config.programs.ags;
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.bar == "ags") {
    home-manager.users.${userSettings.username} = {
      imports = [inputs.ags.homeManagerModules.default];

      # programs.ags = {
      #   enable = true;
      #
      #   # symlink to ~/.config/ags
      #   configDir = ./ags;
      #
      #   # additional packages to add to gjs's runtime
      #   extraPackages = with pkgs; [
      #     inputs.ags.packages.${pkgs.system}.battery
      #     fzf
      #     inputs.ags.packages.${pkgs.system}.io
      #     inputs.ags.packages.${pkgs.system}.astal3
      #     inputs.ags.packages.${pkgs.system}.apps
      #     inputs.ags.packages.${pkgs.system}.auth
      #     inputs.ags.packages.${pkgs.system}.bluetooth
      #     inputs.ags.packages.${pkgs.system}.cava
      #     inputs.ags.packages.${pkgs.system}.greet
      #     inputs.ags.packages.${pkgs.system}.hyprland
      #     inputs.ags.packages.${pkgs.system}.mpris
      #     inputs.ags.packages.${pkgs.system}.network
      #     inputs.ags.packages.${pkgs.system}.notifd
      #     inputs.ags.packages.${pkgs.system}.powerprofiles
      #     inputs.ags.packages.${pkgs.system}.tray
      #     inputs.ags.packages.${pkgs.system}.wireplumber
      #   ];
      # };
      # home.packages = [inputs.astal.packages.${pkgs.system}.default];

      programs.ags.enable = true;

      systemd.user.services.ags = {
        Unit = {
          Description = "Aylur's Gtk Shell";
          PartOf = [
            "tray.target"
            "graphical-session.target"
          ];
          After = "graphical-session.target";
        };
        Service = {
          Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
          ExecStart = "${cfg.package}/bin/ags";
          Restart = "on-failure";
        };
        Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
}
