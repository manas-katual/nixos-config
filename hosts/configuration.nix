#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#
{
  config,
  pkgs,
  userSettings,
  lib,
  inputs,
  ...
}: {
  imports = (
    import ../system
    ++ import ../custom
    ++ import ../modules/desktops
    ++ import ../modules/programs
    ++ import ../modules/theming
    ++ import ../modules/services
    ++ import ../modules/shell
    ++ import ../modules/editors
    ++ import ../modules/hardware
    ++ import ../modules/scripts
  );

  nix.package = pkgs.lix;

  environment = {
    variables = {
      TERMINAL = "${userSettings.terminal}";
      EDITOR = "${userSettings.editor}";
      VISUAL = "${userSettings.editor}";
    };
  };

  programs = {
    dconf.enable = true;
  };

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org?priority=10"

        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # =============== #
  # DONT TOUCH THIS #
  # =============== #

  system.stateVersion = "24.05";

  home-manager.users.${userSettings.username} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
