{ pkgs, config, ... }:
{
  stylix.image = ./nord_roads.png;
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
  };
}

