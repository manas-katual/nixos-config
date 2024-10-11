{ inputs, ... }:

{

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./opts.nix
		./plugins.nix
		./keymaps.nix
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    #colorschemes.gruvbox.enable = true;

  };

}
