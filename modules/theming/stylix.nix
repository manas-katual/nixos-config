{
  pkgs,
  lib,
  userSettings,
  inputs,
  ...
}: let
  themePaths = {
    "atelier-dune" = {
      scheme = "${pkgs.base16-schemes}/share/themes/atelier-dune.yaml";
      image = "${inputs.walls}/comfy.jpg";
    };
    "catppuccin-frappe" = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      image = "${inputs.walls}/monterey.jpg";
    };
    "catppuccin-mocha" = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = "${inputs.walls}/shaded.png";
    };
    "cupertino" = {
      scheme = "${pkgs.base16-schemes}/share/themes/cupertino.yaml";
      image = "${inputs.walls}/monterey.jpg";
    };
    "dracula" = {
      scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
      image = "${inputs.walls}/dracula-mnt.png";
    };
    "everforest" = {
      scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
      image = "${inputs.walls}/forest.jpg";
    };
    "gruvbox-dark-hard" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      image = "${inputs.walls}/ghibli_insider.jpeg";
    };
    "gruvbox-dark-medium" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      image = "${inputs.walls}/gruvbox-car.jpg";
    };
    "gruvbox-material-dark-medium" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
      image = "${inputs.walls}/ledge_gruvbox.png";
    };
    "gruvbox-material-dark-soft" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
      image = "${inputs.walls}/nord_roads.png";
    };
    "nord" = {
      scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      image = "${inputs.walls}/nord_bridge.png";
    };
    "onedark" = {
      scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
      image = "${inputs.walls}/od_neon_warm.png";
    };
    "rose-pine" = {
      scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      image = "${inputs.walls}/uwu.jpg";
    };
    "sakura" = {
      scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";
      image = "${inputs.walls}/pink-katana.jpg";
    };
    "solarized-dark" = {
      scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      image = "${inputs.walls}/solarized-dark.jpg";
    };
    "uwunicorn" = {
      scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
      image = "${inputs.walls}/uwu.jpg";
    };
    "windows-10-light" = {
      scheme = "${pkgs.base16-schemes}/share/themes/windows-10-light.yaml";
      image = "${inputs.walls}/bindows.jpg";
    };
  };
  defaultScheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
  defaultImage = "${inputs.walls}/sky.jpg";
in {
  # Use attribute set to get theme paths
  stylix.base16Scheme = lib.mkDefault (lib.getAttr userSettings.theme themePaths).scheme;
  stylix.image = lib.mkDefault (lib.getAttr userSettings.theme themePaths).image;

  stylix.cursor = {
    package =
      if userSettings.desktop == "hyprland"
      then pkgs.google-cursor
      else pkgs.bibata-cursors;

    name =
      if userSettings.desktop == "hyprland"
      then "GoogleDot-Black"
      else "Bibata-Modern-Ice";

    size = lib.mkForce 18;
  };

  stylix.homeManagerIntegration = {
    autoImport = true;
    followSystem = true;
  };

  stylix.opacity = {
    applications = lib.mkForce 0.9;
    terminal = lib.mkForce 0.9;
    desktop = lib.mkForce 0.9;
    popups = lib.mkForce 0.9;
  };

  stylix.fonts = {
    sizes = {
      applications = lib.mkForce 16;
      terminal = lib.mkForce 16;
      desktop = lib.mkForce 16;
      popups = lib.mkForce 16;
    };
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

    home.file = {
      "Pictures/Wallpapers" = {
        source = "${inputs.walls}";
        recursive = true;
      };
    };
  };
}
