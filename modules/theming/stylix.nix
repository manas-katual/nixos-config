{ pkgs, lib, inputs, config, userSettings, ... }:

let
  themePaths = {
    "gruvbox-dark-hard" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      image = ../wallpapers/forest.jpg;
    };
    "gruvbox-dark-medium" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      image = ../wallpapers/gruvbox-car.jpg;
    };
    "gruvbox-material-dark-medium" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
      image = ../wallpapers/ledge_gruvbox.png;
    };
    "gruvbox-material-dark-soft" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
      image = ../wallpapers/nord_roads.png;
    };
    "solarized-dark" = {
      scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      image = ../wallpapers/solarized-dark.jpg;
    };
    "nord" = {
      scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      image = ../wallpapers/nord_bridge.png;
    };
    "uwunicorn" = {
      scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
      image = ../wallpapers/uwu.jpg;
    };
    "sakura" = {
      scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";
      image = ../wallpapers/pink-katana.jpg;
    };
    "everforest" = {
      scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
      image = ../wallpapers/everforest.png;
    };
    "windows-10-light" = {
      scheme = "${pkgs.base16-schemes}/share/themes/windows-10-light.yaml";
      image = ../wallpapers/bindows.jpg;
    };
    "dracula" = {
      scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
      image = ../wallpapers/dracula-mnt.png;
    };
    "catppuccin-mocha" = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ../wallpapers/shaded.png;
    };
    "atelier-dune" = {
      scheme = "${pkgs.base16-schemes}/share/themes/atelier-dune.yaml";
      image = ../wallpapers/comfy.jpg;
    };
    "onedark" = {
      scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
      image = ../wallpapers/od_neon_warm.png;
    };
  };

  defaultScheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
  defaultImage = ../wallpapers/sky.jpg;

in
{
  # Use attribute set to get theme paths
  stylix.base16Scheme = lib.mkDefault (lib.getAttr userSettings.theme themePaths).scheme;
  stylix.image = lib.mkDefault (lib.getAttr userSettings.theme themePaths).image;


  stylix.cursor = {
    package = lib.mkForce pkgs.google-cursor;
    name = lib.mkForce "GoogleDot-Black";
    size = lib.mkForce 16;
  };

  stylix.homeManagerIntegration = {
    autoImport = true;
    followSystem = true;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = lib.mkForce pkgs.intel-one-mono;
      name = "Intel One Mono";
    };
    serif = {
      package = lib.mkForce pkgs.intel-one-mono;
      name = "Intel One Mono";
    };
  };

  stylix.polarity = "dark";

  home-manager.users.${userSettings.username} = {
    stylix.enable = true;
    stylix.autoEnable = true;
    stylix.targets.waybar.enable = false;
    stylix.targets.rofi.enable = false;
    stylix.targets.kde.enable = true;
    stylix.targets.qt.enable = true;
    stylix.targets.qt.platform = "qtct";
  };
}

