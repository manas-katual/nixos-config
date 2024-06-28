{ inputs, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./opts.nix
  ];

    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      colorschemes.gruvbox.enable = true;

		  plugins = {
			  bufferline = {
				  enable = true;
					alwaysShowBufferline = true;
					colorIcons = true;
					hover.enabled = true;
					highlights.tab.underline = true;
				};

					alpha = {
						enable = true;
						theme = "dashboard";
					};

				lualine.enable = true;
				chadtree.enable = true;
			};
    };

}
