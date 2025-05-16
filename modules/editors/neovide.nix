{
  pkgs,
  userSettings,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      neovide
    ];
  };
  home-manager.users.${userSettings.username} = {
    programs.neovide = {
      enable = true;
      package = pkgs.neovide;
      settings = {
        font = {
          normal = ["Intel One Mono"];
          size = 18.0;
        };
      };
    };
  };
}
