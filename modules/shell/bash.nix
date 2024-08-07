{ pkgs, userSettings, ... }:
{
  
  home-manager.users.${userSettings.username} = {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          fucking-flake-rb = "sudo nixos-rebuild switch --flake ~/setup/";
          ls = "eza --icons";
          tree = "eza --tree --icons";
          cat = "bat";
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
