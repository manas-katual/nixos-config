{
  pkgs,
  userSettings,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    programs = {
      tmux = {
        enable = true;
        package = pkgs.tmux;
        mouse = true;
        shell = "${pkgs.zsh}/bin/zsh";
      };
    };
  };
}
