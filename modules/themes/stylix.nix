{ pkgs, lib, inputs, config, userSettings, ... }:

{

	imports = [ inputs.stylix.nixosModules.stylix ];

	stylix.enable = true;
	
	stylix.base16Scheme = 
    if (userSettings.theme == "gruvbox-dark-hard") 
      then "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml" 
    else if (userSettings.theme == "gruvbox-dark-medium") 
      then "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml" 
    else if (userSettings.theme == "solarized-dark") 
      then "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml"
    else if (userSettings.theme == "nord") 
      then "${pkgs.base16-schemes}/share/themes/nord.yaml"
    else if (userSettings.theme == "uwunicorn") 
      then "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml"
    else if (userSettings.theme == "everforest") 
      then "${pkgs.base16-schemes}/share/themes/everforest.yaml"
    else 
      "${pkgs.base16-schemes}/share/themes/circus.yaml";
  

  stylix.image = 
    if (userSettings.theme == "gruvbox-dark-hard")
      then ../wallpapers/car.jpg
    else if (userSettings.theme == "gruvbox-dark-medium")
      then ../wallpapers/gruvbox-car.jpg
    else if (userSettings.theme == "solarized-dark")
      then ../wallpapers/solarized-dark.jpg
    else if (userSettings.theme == "nord")
      then ../wallpapers/nord_bridge.png
    else if (userSettings.theme == "uwunicorn")
      then ../wallpapers/pink_house.jpg
    else if (userSettings.theme == "everforest")
      then ../wallpapers/everforest.png
    else
      ../wallpapers/sky.jpg;

	
  #stylix.cursor.package = pkgs.bibata-cursors;
  #stylix.cursor.name = "Bibata-Modern-Ice";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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
    terminal = 15;
    desktop = 10;
    popups = 10;
  };

  stylix.opacity = {
    applications = 1.0;
    terminal = 1.0;
    desktop = 1.0;
    popups = 1.0;
  };
  
 
 home-manager.users.${userSettings.username} = {
    qt = {
      enable = true;
      style.package = pkgs.libsForQt5.breeze-qt5;
      style.name = "breeze-dark";
      platformTheme.name = "kde";
    };
    
    gtk = {    
			enable = true;
			iconTheme = {
				package = pkgs.papirus-icon-theme;
				name = "Papirus-Dark";
			};
      gtk3 = {
			  extraConfig = {
				  gtk-application-prefer-dark-theme = 1;
			  };
		  };
		  gtk4 = {
			  extraConfig = {
				  gtk-application-prefer-dark-theme = 1;
			  };
		  };

    };
 };

}

