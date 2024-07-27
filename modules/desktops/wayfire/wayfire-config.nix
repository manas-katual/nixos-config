{ config, lib, ... }:
{
  xdg.configFile = {
    # you don't have to rebuild..., but have to give full path..
    "wayfire.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/smaalks/setup/modules/desktops/wayfire/wayfire.ini";
  };
}
