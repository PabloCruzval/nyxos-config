{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        statusline.lualine.enable = true;
        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
        terminal = {
          toggleterm.enable = true;
        };

        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
        };

        options = {
          tabstop = 4;
          shiftwidth = 0;
        };
        formatter = {
          conform-nvim.enable = true;
        };

        telescope = {
          enable = true;
          mappings = {
            buffers = "<leader>tb";
            diagnostics = "<leader>td";
            findFiles = "<leader>tf";
            lspDefinitions = "<leader>ld";
          };
        };
        keymaps = [
          {
            key = "<leader>tr";
            mode = "n";
            action = "<cmd> Telescope oldfiles <CR>";
          }
          # Move one line
          {
            key = "<A-k>";
            mode = ["n" "i"];
            action = "<cmd>m -2<CR>";
          }
          {
            key = "<A-j>";
            mode = ["n" "i"];
            action = "<cmd>m +1<CR>";
          }
          # Move many lines
          {
            key = "<A-k>";
            mode = "v";
            action = ":m '<-2<CR>gv=gv";
          }
          {
            key = "<A-j>";
            mode = "v";
            action = ":m '>+1<CR>gv=gv";
          }
          {
            key = "<leader>e";
            mode = "n";
            action = ":e .<CR>";
          }
          # Clear search
          {
            key = "<leader>h";
            mode = ["n" "v"];
            action = ":nohlsearch<CR>";
          }
          # Copy text
          {
            key = "<leader>y";
            mode = ["n" "v"];
            action = "\"+y";
            desc = "Copy";
          }
          # Buffer Actions
          {
            key = "<leader>bx";
            mode = "n";
            action = ":bdelete<CR>";
            desc = "Buffer: Delete";
          }
          {
            key = "<leader>bp";
            mode = "n";
            action = ":bprevious<CR>";
            desc = "Buffer: Previous";
          }
          # Spell check
          {
            key = "<leader>sc";
            mode = "n";
            action = "z=1<Enter><CR>";
            desc = "Correct spell";
          }
        ];
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableDAP = true;
          enableFormat = true;
          enableTreesitter = true;

          astro.enable = true;
          nix.enable = true;
          ts.enable = true;
          clang.enable = true;
          python.enable = true;
        };

        debugger.nvim-dap = {
          enable = true;
          ui = {
            enable = true;
            setupOpts = {
              layouts = [
                {
                  elements = [
                    {
                      id = "scopes";
                      size = 0.25;
                    }
                    {
                      id = "breakpoints";
                      size = 0.25;
                    }
                    {
                      id = "stacks";
                      size = 0.25;
                    }
                    {
                      id = "watches";
                      size = 0.25;
                    }
                  ];
                  position = "left";
                  size = 40;
                }
                {
                  elements = [
                    {
                      id = "repl";
                      size = 1.0;
                    } # Solo REPL, sin console
                  ];
                  position = "bottom";
                  size = 10;
                }
              ];
            };
          };
        };
        luaConfigRC.dap-external-terminal = ''
          vim.defer_fn(function()
            local dap = require('dap')

            -- Configurar terminal externa
            dap.defaults.fallback.external_terminal = {
              command = 'kitty',  -- cambia por tu terminal
              args = {'-e'}
            }

            -- Aplicar a todas las configuraciones existentes
            for lang, configs in pairs(dap.configurations) do
              if type(configs) == 'table' then
                for _, config in ipairs(configs) do
                  config.console = 'externalTerminal'
                end
              end
            end
          end, 500)
        '';
      };
    };
  };
}
