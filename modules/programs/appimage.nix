{ pkgs, config, ... }:

{
  programs.appimage = {
		enable = true;
		binfmt = true;
	};
}

