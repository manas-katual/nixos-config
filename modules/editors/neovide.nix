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
          normal = ["JetBrainsMono Nerd Font Mono"];
          size = 18.0;
        };
      };
    };
  };
}
