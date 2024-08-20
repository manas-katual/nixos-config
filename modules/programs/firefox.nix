{ config, pkgs, inputs, userSettings, ... }:

{
	home-manager.users.${userSettings.username} = {
		programs.firefox = {
			enable = false;
			profiles = {
				"user" = {
					id = 0;
					isDefault = true;

					search.engines = {
						"Nix Packages" = {
							urls = [{
								template = "https://search.nixos.org/packages";
								params = [
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];
							icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
							definedAliases = [ "@np" ];
						};
						"Nix Options" = {
							definedAliases = [ "@no" ];
							urls = [{
								template = "https://search.nixos.org/options";
								params = [
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];
						};
						"Home Manager" = {
							definedAliases = [ "@hm" ];
							urls = [{
								template = "https://home-manager-options.extranix.com";
								params = [
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];
						};
					};
						bookmarks = [
							{
								name = "wikipedia";
								tags = [ "wiki" ];
								keyword = "wiki";
								url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
							}
						];

						extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
							ublock-origin
							darkreader
						];
				};
			};
		};
	};
}
