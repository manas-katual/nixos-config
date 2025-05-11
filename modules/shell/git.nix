{ userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    programs.git = {
      enable = true;
      userName = "${userSettings.gitUsername}";
      userEmail = "${userSettings.gitEmail}";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
