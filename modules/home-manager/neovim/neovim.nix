{ config, pkgs, ...}:
{
  programs = {
    neovim = {
      enable = true;
      # extrapackages = with pkgs; [
        
      # ];
       plugins = with pkgs; [
        vimPlugins.catppuccin-nvim
      ];
    };
  };
}
