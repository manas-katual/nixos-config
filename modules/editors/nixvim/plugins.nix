{
	programs.nixvim = {
		plugins = {

			# tabs
			bufferline = {
				enable = true;
				settings = {
					options = {
						hover.enabled = true;
						always_show_bufferline = true;
						color_icons = true;
					};
					highlights.tab.underline = true;
				};
			};

			# web devicons
			web-devicons.enable = true;
			mini = {
				enable = true;
			};
			
			# dashboard
			alpha = {
				enable = true;
				theme = "dashboard";
			};

			# modeline
			lualine.enable = true;
			
			# sidebar folder view
			chadtree = {
				enable = true;
				view.width = 40;
			};

			# neorg


		};
	};
}
