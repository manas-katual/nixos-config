# Eza is a ls replacement
{userSettings, ...}: {
  home-manager.users.${userSettings.username} = {
    programs.eza = {
      enable = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
        "--no-quotes"
        "--git-ignore"
        "--icons=always"
      ];
    };
  };
}
