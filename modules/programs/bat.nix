{userSettings ,pkgs, ...}: 

{
  home-manager.users.${userSettings.username} = {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        batgrep
      ];
    };
  };
}

