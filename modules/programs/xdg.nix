{ userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}

