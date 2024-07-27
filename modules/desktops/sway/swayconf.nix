{ pkgs, config, lib, ... }:
{
    xdg.configFile."sway/config".source = pkgs.lib.mkOverride 0 "/home/smaalks/setup/modules/desktops/sway/config";
    #xdg.configFile."sway/config".source = pkgs.lib.mkOverride 0 "./config";
}
