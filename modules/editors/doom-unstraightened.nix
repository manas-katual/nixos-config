{
  config,
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    imports = [inputs.nix-doom-emacs-unstraightened.hmModule];

    programs.doom-emacs = {
      enable = true;
      doomDir = ./doom-unstraightened; # or e.g. `./doom.d` for a local configuration
    };
  };
}
