{ inputs, ... }:

{

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./opts.nix
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    #colorschemes.gruvbox.enable = true;

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
			#chadtree.enable = true;
			neo-tree.enable = true;
		};
		
  	globals = {
    	mapleader = " ";
    	maplocalleader = " ";
  	};

		keymaps = [
			{
      	key = "<leader>e";
      	action = "<CMD>Neotree toggle<CR>";
      	options.desc = "Toggle NeoTree";
    	}
		];
  };

}
