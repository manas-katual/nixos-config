{ pkgs, lib, ... }:

{
    environment = {
      systemPackages = with pkgs; [
        ripgrep
        fd
      ];
    };
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
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
          enableLSP = true;
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
      };
    };
  };
}

