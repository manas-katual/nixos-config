{ config, pkgs, inputs, userSettings, ... }:
{
  home-manager.users.${userSettings.username} = {
    imports = [ inputs.ags.homeManagerModules.default ];

    programs.ags = {
      enable = true;

      # symlink to ~/.config/ags
      configDir = ./ags;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.battery
        fzf
      ];
    };
    home.packages = [inputs.astal.packages.${pkgs.system}.default];
  };
}
