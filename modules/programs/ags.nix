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
        configDir = ./ags;

        # additional packages to add to gjs's runtime
        extraPackages = with pkgs; [
          gtksourceview
          webkitgtk
          accountsservice
          inputs.ags.packages.${pkgs.system}.astal4
          inputs.ags.packages.${pkgs.system}.io
          inputs.ags.packages.${pkgs.system}.hyprland
          inputs.ags.packages.${pkgs.system}.mpris
          inputs.ags.packages.${pkgs.system}.battery
          inputs.ags.packages.${pkgs.system}.wireplumber
          inputs.ags.packages.${pkgs.system}.network
          inputs.ags.packages.${pkgs.system}.bluetooth
          inputs.ags.packages.${pkgs.system}.tray
        ];
      };
      home.packages = with pkgs; [
        # Core dependencies
        gtk3
        gtk4
        gtksourceview
        webkitgtk
        accountsservice

        # Styling and theming
        sassc # SCSS compiler
        dart-sass # Alternative SCSS compiler

        # Our widget dependencies
        matugen # Material You color generator
        swww # Wallpaper daemon
        hyprpicker # Color picker
        wl-clipboard # Clipboard utilities
        grim # Screenshot utility
        slurp # Screen area selector

        # System info
        btop # For system monitoring widgets
        pamixer # Audio control
        brightnessctl # Brightness control
        networkmanager # Network management

        # Optional but useful
        jq # JSON processing
        socat # Socket communication
        ripgrep # Fast searching
        fd # Fast file finding
      ];

      # Environment variables for AGS
      home.sessionVariables = {
        AGS_SKIP_V1_DEPRECATION_WARNING = "1";
      };
    };
  };
}
