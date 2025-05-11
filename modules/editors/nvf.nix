{ pkgs, lib, inputs, userSettings, ... }:

{
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
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;        
          options = {
            tabstop = 2;
            shiftwidth = 2;
            wrap = false;
          };
          preventJunkFiles = true;
          theme = {
            enable = true;
            # name = "gruvbox";
            # style = "dark";
          };
          lsp = {
            enable = true;
          };
          statusline = {
            lualine = {
            enable = true;
            };
          };
          telescope = {
            enable = true;
          };
          autocomplete = {
            nvim-cmp = {
            enable = true;
            };
          };

          # languages
          languages = {
            # enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;
            nix = {
              enable = true;
            };
            ts = {
              enable = true;
            };
            rust = {
              enable = true;
            };
            java = {
              enable = true;
            };
            python = {
              enable = true;
            };
            bash = {
              enable = true;
            };
            html = {
              enable = true;
            };
            markdown = {
              enable = true;
            };
            css = {
              enable = true;
            };
            clang = {
              enable = true;
            };
          };

          # decoration
          dashboard = {
            alpha = {
              enable = true;
            };
          };
          filetree = {
            neo-tree = {
              enable = true;
            };
          };
          visuals = {
            indent-blankline = {
              enable = true;
            };
            nvim-web-devicons = {
              enable = true;
            };
            cinnamon-nvim = {
              enable = true;
            };
            fidget-nvim = {
              enable = true;
            };
          };

          # neorg
          notes = {
            neorg = {
              enable = true;
              treesitter = {
                enable = true;
              };
              setupOpts = {
                load = {
                  "core.defaults" = {
                    enable = true;
                  };
                };
              };
            };
          };

          # keymaps
          keymaps = [
            {
              key = "<leader>e";
              mode = "";
              action = "<CMD>Neotree<CR>";
              desc = "Open neo-tree";
            }
          ];

          # terminal
          terminal = {
            toggleterm = {
              enable = true;
            };
          };
        };
      };
    };
  };
}

