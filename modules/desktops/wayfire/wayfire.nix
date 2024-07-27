{ pkgs, config, lib, options, ... }:
{
  options = lib.mkIf (config.my.desktop.option == "wayfire") {
    programs.wayfire = {
      enable = true;
      package = pkgs.wayfire;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };  
}
