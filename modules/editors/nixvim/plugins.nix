{
	programs.nixvim = {
		plugins = {

			# tabs
			bufferline = {
				enable = true;
				alwaysShowBufferline = true;
				colorIcons = true;
				hover.enabled = true;
				highlights.tab.underline = true;
			};
			
			# dashboard
			alpha = {
				enable = true;
				theme = "dashboard";
			};

			#dashboard = { 
			#	enable = true;
			#	settings = { 
			#		config = {
			#			footer = [
			#				"Made with ❤️"
			#			];
			#			header = [
			#				"███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
			#				"████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
			#				"██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
			#				"██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
			#				"██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
			#				"╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
			#			];
			#		};
			#		theme = "doom";
			#	};
			#};

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
