{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:
with lib; {
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    services = {
      libinput.enable = true;
      #xkb = {
      #  layout = "us";
      #options = "eurosign:e";
      #};
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
        dconf-editor
        gnome-tweaks
      ];
      gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-system-monitor
        epiphany
      ];
    };

    home-manager.users.${userSettings.username} = {
      home.packages = with pkgs.gnomeExtensions; [
        blur-my-shell
        open-bar
        #caffeine
        forge
        #pip-on-top
        #system-monitor
      ];

      dconf.settings = {
        "org/gnome/shell" = {
          enabled-extensions = [
            "blur-my-shell@aunetx"
            "forge@jmmaranan.com"
          ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          clock-show-weekday = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/shell/extensions/forge" = {
          window-gap-size = 8;
          dnd-center-layout = "swap";
        };
        "org/gnome/shell/extensions/forge/keybindings" = {
          # Set Manually
          focus-border-toggle = true;
          float-always-on-top-enabled = true;
          window-focus-up = ["<super>k"];
          window-focus-down = ["<super>j"];
          window-focus-left = ["<super>h"];
          window-focus-right = ["<super>l"];
          window-move-up = ["<shift><super>k"];
          window-move-down = ["<shift><super>j"];
          window-move-left = ["<shift><super>h"];
          window-move-right = ["<shift><super>l"];
          window-swap-last-active = ["@as []"];
          window-toggle-float = ["<shift><super>f"];
        };
        "org/gnome/desktop/wm/keybindings" = {
          # maximize = ["<super>up"]; # Floating
          # unmaximize = ["<super>down"];
          maximize = ["@as []"]; # Tiling
          unmaximize = ["@as []"];
          switch-input-source = ["@as []"];
          switch-input-source-backward = ["@as []"];
          switch-to-workspace-left = ["<alt>left"];
          switch-to-workspace-right = ["<alt>right"];
          switch-to-workspace-1 = ["<alt>1"];
          switch-to-workspace-2 = ["<alt>2"];
          switch-to-workspace-3 = ["<alt>3"];
          switch-to-workspace-4 = ["<alt>4"];
          switch-to-workspace-5 = ["<alt>5"];
          move-to-workspace-left = ["<shift><alt>left"];
          move-to-workspace-right = ["<shift><alt>right"];
          move-to-workspace-1 = ["<shift><alt>1"];
          move-to-workspace-2 = ["<shift><alt>2"];
          move-to-workspace-3 = ["<shift><alt>3"];
          move-to-workspace-4 = ["<shift><alt>4"];
          move-to-workspace-5 = ["<shift><alt>5"];
          move-to-monitor-left = ["<super><alt>left"];
          move-to-monitor-right = ["<super><alt>right"];
          close = ["<super>q" "<alt>f4"];
          toggle-fullscreen = ["<super>f"];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          ];
          search = ["<super>space"];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<super>return";
          command = "kitty";
          name = "open-terminal";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<super>t";
          command = "kitty nvim";
          name = "open-editor";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          binding = "<super>e";
          command = "nautilus";
          name = "open-file-browser";
        };
      };

      #xdg.desktopEntries.GDrive = {
      #  name = "GDrive";
      #  exec = "${pkgs.rclone}/bin/rclone mount --daemon gdrive: /GDrive --vfs-cache-mode=writes";
      #};
    };
  };
}
