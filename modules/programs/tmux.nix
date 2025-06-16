{
  pkgs,
  userSettings,
  config,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    programs = {
      tmux = {
        enable = true;
        package = pkgs.tmux;
        mouse = true;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "tmux-256color";
        plugins = with pkgs; [
          tmuxPlugins.sensible
          tmuxPlugins.vim-tmux-navigator
        ];
        extraConfig = ''
                              set-option -sa terminal-overrides ",xterm*:Tc"
                              set -g @plugin 'tmux-plugins/tmux-sensible'
                              set -g @plugin 'christoomey/vim-tmux-navigator'

                              set -g status on
                              set -g status-justify left
                              set -g status-left-length 100
                              set -g status-right-length 100

                              # Messages
                              set -g message-style fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base01},align=centre
                              set -g message-command-style fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base01},align=centre

                              # Panes
                              set -g pane-border-style fg=#${config.lib.stylix.colors.base01}
                              set -g pane-active-border-style fg=#${config.lib.stylix.colors.base0D}

                              # Windows
                              setw -g window-status-style fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00},none
                              setw -g window-status-current-style fg=colour232,bg=#${config.lib.stylix.colors.base0D},bold
                              setw -g window-status-format "#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0D}] #I #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] #W "
                              setw -g window-status-current-format "#[fg=colour232,bg=#${config.lib.stylix.colors.base0D}] #I #[fg=colour255,bg=#${config.lib.stylix.colors.base01}] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "

                              # Status line segments (left and right)
                              set -g status-left ""

                              # set -g status-right "\
                              # #[fg=#${config.lib.stylix.colors.base0D},bg=#${config.lib.stylix.colors.base00}]\
                              # #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0D},bold]  #W \
                              # #[fg=#${config.lib.stylix.colors.base0D},bg=#${config.lib.stylix.colors.base00}]\
                              # #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0D},bold]  #S"


                    # set -g status-right "\
                    # #[fg=#${config.lib.stylix.colors.base0D},bg=#${config.lib.stylix.colors.base00}]\
                    # #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0D},bold]  #{pane_current_command} \
                    # #[fg=#${config.lib.stylix.colors.base0B},bg=#${config.lib.stylix.colors.base00}]\
                    # #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0B},bold]  #S "

          set -g status-right "\
          #[fg=#${config.lib.stylix.colors.base09},bg=#${config.lib.stylix.colors.base00}]\
          #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base09}] #{b:pane_current_path}\
          #[fg=#${config.lib.stylix.colors.base0E},bg=#${config.lib.stylix.colors.base09}]\
          #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0E}] #{pane_current_command}\
          #[fg=#${config.lib.stylix.colors.base0B},bg=#${config.lib.stylix.colors.base0E}]\
          #[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0B}] #S "
        '';
      };
    };
  };
}
