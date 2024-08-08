{ pkgs, config, ... }:
{
  stylix.image = ../wallpapers/nord_roads.png;
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
  };
}

