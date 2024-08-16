{ pkgs, userSettings, lib, ... }:

{

	home-manager.users.${userSettings.username} = {
		home.pointerCursor = {
			gtk.enable = true;
			#x11.enable = true;
			package = lib.mkForce pkgs.google-cursor;
			name = lib.mkForce "GoogleDot-Black";
			size = lib.mkForce 24;
		};
	};
}
