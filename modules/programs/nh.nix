{
  pkgs,
  userSettings,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${userSettings.username}/setup";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
