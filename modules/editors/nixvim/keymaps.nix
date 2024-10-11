{
	programs.nixvim = {
		globals = {
			mapleader = " ";
			maplocalleader = " ";
		};

		keymaps = [
			# chad tree
			{
				key = "<leader>ne";
				action = "<CMD>:CHADopen<CR>";
				options.desc = "Toggle ChadTree";
			}

			# switching buffers
			{
				key = "<leader>bp";
				action = "<CMD>:bp<CR>";
				options.desc = "Previous buffer";
			}
			{
				key = "<leader>bn";
				action = "<CMD>:bn<CR>";
				options.desc = "Next buffer";
			}
			{
				key = "<leader>bi";
				action = "<CMD>:ls<CR>";
				options.desc = "list buffer";
			}
		];
	};
}
