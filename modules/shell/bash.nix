{ pkgs, userSettings, ... }:
{
  
  environment.pathsToLink = [ "/share/bash-completion" ];

  home-manager.users.${userSettings.username} = {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          fucking-flake-rb = "sudo nixos-rebuild switch --flake ~/setup/";
          ls = "eza --icons";
					vi = "nvim";
					vim = "nvim";
          tree = "eza --tree --icons";
          cat = "bat";
					img = "kitten icat";
        };
      };
      oh-my-posh = {
        enable = true;
        useTheme = "robbyrussell";
        enableBashIntegration = true;
        package = pkgs.oh-my-posh; 
      };
      bash.bashrcExtra = ''
        eval "$(oh-my-posh init bash)"
        export PATH="$HOME/.config/emacs/bin:$PATH"
      '';
    };
  };
}
