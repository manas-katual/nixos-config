#
#  Shell
#

{ pkgs, userSettings, ... }:

{
  users.users.${userSettings.username} = {
    shell = pkgs.zsh;
  };

  home-manager.users.${userSettings.username} = {
  programs = {
      oh-my-posh = {
        enable = true;
        useTheme = "robbyrussell";
        enableZshIntegration = true;
        package = pkgs.oh-my-posh; 
      };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      #histSize = 100000;
      initExtra = ''
        eval "$(oh-my-posh init zsh)"
      '';
      };
  };
  };

  programs.zsh.enable = true;

      #ohMyZsh = {
      #  enable = true;
      #  plugins = [ "git" ];
      #};


      #shellInit = ''
      #  # Spaceship
      #  source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      #  autoload -U promptinit; promptinit
      #  # Hook direnv
      #  #emulate zsh -c "$(direnv hook zsh)"

      #  #eval "$(direnv hook zsh)"
      #'';

}
