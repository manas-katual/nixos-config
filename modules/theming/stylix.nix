{ pkgs, lib, inputs, config, userSettings, ... }:

{

#	imports = [ inputs.stylix.nixosModules.stylix ];

	stylix.enable = true;
	
	stylix.base16Scheme = 
    if (userSettings.theme == "gruvbox-dark-hard") 
      then "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml" 
    else if (userSettings.theme == "gruvbox-dark-medium") 
      then "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml" 
    else if (userSettings.theme == "gruvbox-material-dark-medium") 
      then "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml" 
    else if (userSettings.theme == "solarized-dark") 
      then "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml"
    else if (userSettings.theme == "nord") 
      then "${pkgs.base16-schemes}/share/themes/nord.yaml"
    else if (userSettings.theme == "uwunicorn") 
      then "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml"
    else if (userSettings.theme == "sakura") 
      then "${pkgs.base16-schemes}/share/themes/sakura.yaml"
    else if (userSettings.theme == "everforest") 
      then "${pkgs.base16-schemes}/share/themes/everforest.yaml"
    else if (userSettings.theme == "windows-10-light") 
      then "${pkgs.base16-schemes}/share/themes/windows-10-light.yaml"
    else if (userSettings.theme == "dracula") 
      then "${pkgs.base16-schemes}/share/themes/dracula.yaml"
    else if (userSettings.theme == "catppuccin-mocha") 
      then "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"
    else 
      "${pkgs.base16-schemes}/share/themes/circus.yaml";
  

  stylix.image = 
    if (userSettings.theme == "gruvbox-dark-hard")
      then ../wallpapers/car.jpg
    else if (userSettings.theme == "gruvbox-dark-medium")
      then ../wallpapers/gruvbox-car.jpg
    else if (userSettings.theme == "gruvbox-material-dark-medium")
      then ../wallpapers/ledge_gruvbox.png
    else if (userSettings.theme == "solarized-dark")
      then ../wallpapers/solarized-dark.jpg
    else if (userSettings.theme == "nord")
      then ../wallpapers/nord_bridge.png
    else if (userSettings.theme == "uwunicorn")
      then ../wallpapers/uwu.jpg
    else if (userSettings.theme == "sakura")
      then ../wallpapers/pink-katana.jpg
    else if (userSettings.theme == "everforest")
      then ../wallpapers/everforest.png
    else if (userSettings.theme == "windows-10-light")
      then ../wallpapers/bindows.jpg
    else if (userSettings.theme == "dracula")
      then ../wallpapers/dracula-mnt.png
    else if (userSettings.theme == "catppuccin-mocha")
      then ../wallpapers/shaded.png
    else
      ../wallpapers/sky.jpg;

	
  stylix = {
    cursor ={
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
      size = 16;
    };
  };

  stylix.homeManagerIntegration = {
    autoImport = true;
    followSystem = true;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];};
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = lib.mkForce pkgs.intel-one-mono;
      name = "Intel One Mono";
    };
    serif = {
      package = lib.mkForce pkgs.intel-one-mono;
      name = "Intel One Mono";
    };
  };

  stylix.polarity = "dark";


	stylix.fonts.sizes = {
    applications = 14;
    terminal = 14;
    desktop = 10;
    popups = 10;
  };

  stylix.opacity = {
    applications = 1.0;
    terminal = 1.0;
    desktop = 1.0;
    popups = 1.0;
  };
 

}

