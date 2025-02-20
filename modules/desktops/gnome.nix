{ config, lib, pkgs, userSettings, ... }:

with lib;
{
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    programs = {
      zsh.enable = true;
    };

    services = {
      libinput.enable = true;
      xserver = {
        enable = true;
        #xkb = {
        #  layout = "us";
          #options = "eurosign:e";
        #};
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        dconf-editor
        epiphany
        geary
        # gnome-characters
        # gnome-contacts
        # gnome-initial-setup
        gnome-tweaks
        #yelp
      ];
      gnome.excludePackages = (with pkgs; [
        # gnome-tour
      ]);
    };

    home-manager.users.${userSettings.username} = {

      home.packages = with pkgs.gnomeExtensions; [
        #blur-my-shell
        #caffeine
        #forge
        #pip-on-top
        #system-monitor
      ];

      #xdg.desktopEntries.GDrive = {
      #  name = "GDrive";
      #  exec = "${pkgs.rclone}/bin/rclone mount --daemon gdrive: /GDrive --vfs-cache-mode=writes";
      #};
    };
  };
}
