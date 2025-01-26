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
        settings = {
          #{
  version = 2;
  final_space = true;
  console_title_template = "{{ .Shell }} in {{ .Folder }}";
  blocks = [
    {
      type = "prompt";
      alignment = "left";
      newline = true;
      segments = [
        {
          type = "path";
          style = "plain";
          background = "transparent";
          foreground = "blue";
          template = "{{ .Path }}";
          properties = {
            style = "full";
          };
        }
        {
          type = "git";
          style = "plain";
          foreground = "p:grey";
          background = "transparent";
          template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
          properties = {
            branch_icon = "";
            commit_icon = "@";
            fetch_status = true;
          };
        }
      ];
    }
    {
      type = "rprompt";
      overflow = "hidden";
      segments = [
        {
          type = "executiontime";
          style = "plain";
          foreground = "yellow";
          background = "transparent";
          template = "{{ .FormattedMs }}";
          properties = {
            threshold = 5000;
          };
        }
      ];
    }
    {
      type = "prompt";
      alignment = "left";
      newline = true;
      segments = [
        {
          type = "text";
          style = "plain";
          foreground_templates = [
            "{{if gt .Code 0}}red{{end}}"
            "{{if eq .Code 0}}magenta{{end}}"
          ];
          background = "transparent";
          template = "❯";
        }
      ];
    }
  ];
  transient_prompt = {
    foreground_templates = [
      "{{if gt .Code 0}}red{{end}}"
      "{{if eq .Code 0}}magenta{{end}}"
    ];
    background = "transparent";
    template = "❯ ";
  };
  secondary_prompt = {
    foreground = "magenta";
    background = "transparent";
    template = "❯❯ ";
  };
          #}
        };
      };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      #histSize = 100000;
      initExtra = ''
        eval "$(oh-my-posh init zsh)"
	export PATH="$HOME/.config/emacs/bin:$PATH"
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
