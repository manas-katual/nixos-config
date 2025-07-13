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
      image = "${inputs.walls}/sonoma-hills.jpg";
    };
    "catppuccin-macchiato" = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      image = "${inputs.walls}/sonoma-hills.jpg";
    };
    "catppuccin-mocha" = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = "${inputs.walls}/space.jpg";
    };
    "cupertino" = {
      scheme = "${pkgs.base16-schemes}/share/themes/cupertino.yaml";
      image = "${inputs.walls}/monterey.jpg";
    };
    "dracula" = {
      scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
      image = "${inputs.walls}/Rainnight.jpg";
    };
    "everforest" = {
      scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
      image = "${inputs.walls}/forest.jpg";
    };
    "gruvbox-dark-hard" = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      image = "${inputs.walls}/hyprland.png";
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
      image = "${inputs.walls}/chaos.png";
    };
    "helios" = {
      scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
      image = "${inputs.walls}/gruv-temple.png";
    };
    "kanagawa" = {
      scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      image = "${inputs.walls}/berries.jpg";
    };
    "macintosh" = {
      scheme = "${pkgs.base16-schemes}/share/themes/macintosh.yaml";
      image = "${inputs.walls}/sonoma-hills.jpg";
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
    "rose-pine-moon" = {
      scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
      image = "${inputs.walls}/sonoma-hills.jpg";
    };
    "sakura" = {
      scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";
      image = "${inputs.walls}/pink-katana.jpg";
    };
    "solarized-dark" = {
      scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      image = "${inputs.walls}/under_water.png";
    };
    "uwunicorn" = {
      scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
      image = "${inputs.walls}/uwu.jpg";
    };
    "windows-10-light" = {
      scheme = "${pkgs.base16-schemes}/share/themes/windows-10-light.yaml";
      image = "${inputs.walls}/nixos.jpg";
    };
  };
  defaultScheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
  defaultImage = "${inputs.walls}/sky.jpg";
in {
  # Use attribute set to get theme paths
  stylix.base16Scheme = lib.mkDefault (lib.getAttr userSettings.theme themePaths).scheme;
  stylix.image = lib.mkDefault (lib.getAttr userSettings.theme themePaths).image;

  stylix.enable = true;
  stylix.cursor = {
    package =
      if userSettings.desktop == "hyprland"
      then pkgs.google-cursor
      else pkgs.bibata-cursors;

    name =
      if userSettings.desktop == "hyprland"
      then "GoogleDot-Black"
      else "Bibata-Modern-Ice";

    size = lib.mkForce 20;
  };

  # stylix.homeManagerIntegration = {
  #   autoImport = true;
  #   followSystem = true;
  # };

  stylix.opacity = {
    applications = lib.mkForce 0.9;
    terminal = lib.mkForce 0.9;
    desktop = lib.mkForce 0.9;
    popups = lib.mkForce 0.9;
  };

  stylix.fonts = {
    sizes = {
      applications = lib.mkForce 18;
      terminal = lib.mkForce 18;
      desktop = lib.mkForce 16;
      popups = lib.mkForce 16;
    };
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = lib.mkForce pkgs.montserrat;
      name = "Montserrat";
    };
    serif = {
      package = lib.mkForce pkgs.montserrat;
      name = "Montserrat";
    };
  };

  stylix.polarity =
    if userSettings.theme == "windows-10-ight"
    then "light"
    else "dark";

  home-manager.users.${userSettings.username} = {
    # stylix.enable = true;
    # stylix.autoEnable = true;
    stylix.targets.waybar.enable = false;
    stylix.targets.rofi.enable = false;
    # stylix.targets.kde.enable = true;
    # stylix.targets.qt.enable = true;
    # stylix.targets.emacs.enable = false;
    # stylix.targets.qt.platform = "qtct";

    stylix.targets.firefox.profileNames = ["${userSettings.username}"];

    home.file = {
      "Pictures/Wallpapers" = {
        source = "${inputs.walls}";
        recursive = true;
      };
    };
  };
}
