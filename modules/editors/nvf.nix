{
  pkgs,
  inputs,
  config,
  userSettings,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
  home-manager.users.${userSettings.username} = {
    imports = [inputs.nvf.homeManagerModules.default];

    programs.nvf = {
      enable = true;

      settings.vim = {
        vimAlias = true;
        viAlias = true;
        withNodeJs = true;
        preventJunkFiles = true;

        options = {
          tabstop = 4;
          shiftwidth = 2;
          wrap = false;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers = {
            wl-copy.enable = true;
            xsel.enable = true;
          };
        };

        maps = {
          normal = {
            "<leader>e" = {
              action = "<CMD>Neotree toggle<CR>";
              silent = false;
            };
          };
        };

        diagnostics = {
          enable = true;
          config = {
            virtual_lines.enable = true;
            underline = true;
          };
        };

        keymaps = [
          {
            key = "jk";
            mode = ["i"];
            action = "<ESC>";
            desc = "Exit insert mode";
          }
          {
            key = "<leader>nh";
            mode = ["n"];
            action = ":nohl<CR>";
            desc = "Clear search highlights";
          }
          {
            key = "<leader>ff";
            mode = ["n"];
            action = "<cmd>Telescope find_files<cr>";
            desc = "Search files by name";
          }
          {
            key = "<leader>lg";
            mode = ["n"];
            action = "<cmd>Telescope live_grep<cr>";
            desc = "Search files by contents";
          }
          {
            key = "<leader>fe";
            mode = ["n"];
            action = "<cmd>Neotree toggle<cr>";
            desc = "File browser toggle";
          }
          {
            key = "<C-h>";
            mode = ["i"];
            action = "<Left>";
            desc = "Move left in insert mode";
          }
          {
            key = "<C-j>";
            mode = ["i"];
            action = "<Down>";
            desc = "Move down in insert mode";
          }
          {
            key = "<C-k>";
            mode = ["i"];
            action = "<Up>";
            desc = "Move up in insert mode";
          }
          {
            key = "<C-l>";
            mode = ["i"];
            action = "<Right>";
            desc = "Move right in insert mode";
          }
        ];

        telescope.enable = true;

        spellcheck = {
          enable = false;
          languages = ["en"];
          programmingWordlist.enable = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          clang.enable = true;
          zig.enable = true;
          python.enable = true;
          markdown.enable = true;
          ts = {
            enable = true;
            lsp.enable = true;
            format.type = "prettierd";
            extensions.ts-error-translator.enable = true;
          };

          html.enable = true;
          css.enable = true;
          bash.enable = true;
          java.enable = true;
          typst.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          rainbow-delimiters.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "base16";
          };
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = false;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        projects.project-nvim.enable = true;
        dashboard.alpha.enable = true;

        filetree.neo-tree.enable = true;

        notify = {
          nvim-notify.enable = true;
          nvim-notify.setupOpts.background_colour = "#${config.lib.stylix.colors.base01}";
        };

        utility = {
          preview.markdownPreview.enable = true;
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = false;
          };
          fastaction.enable = true;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
