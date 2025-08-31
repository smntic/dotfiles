{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings = {
      vim = {
        startPlugins = [ pkgs.vimPlugins.playground ];

        extraPlugins = {
          marks = {
            package = pkgs.vimPlugins.marks-nvim;
            setup = ''
              require('marks').setup({
                -- whether to map keybinds or not. default true
                default_mappings = true,

                -- which builtin marks to show. default {}
                builtin_marks = { ".", "<", ">", "^" },

                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,

                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,

                -- how often (in ms) to redraw signs/recompute mark positions. 
                -- higher values will have better performance but may cause visual lag, 
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 150,
              })
            '';
          };

          # overseer = {
          #   package = pkgs.vimPlugins.overseer-nvim;
          #   setup = ''
          #     local overseer = require("overseer")
          #     overseer.setup({
          #       strategy = {
          #         "toggleterm",
          #         open_on_start = true,
          #       },
          #
          #       component_aliases = { 
          #         default = {
          #           { "display_duration", detail_level = 2 },
          #           "on_output_summarize",
          #           "on_exit_set_status",
          #           -- "on_complete_notify",
          #           { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
          #         },
          #       },
          #     })
          #
          #     overseer.register_template({
          #       name = "g++ build for competitive programming",
          #       builder = function()
          #         local file = vim.fn.expand("%:p")
          #         local basename = vim.fn.expand("%:r")
          #         return {
          #           cmd = { "g++" },
          #           args = { "-Wall", "-g", "-o", basename, file },
          #         }
          #       end,
          #       condition = { filetype = { "cpp" } },
          #       tags = { "build" },
          #     })
          #
          #     overseer.register_template({
          #       name = "C++ Run Executable",
          #       strategy = { "toggleterm", use_shell = true, hidden = true, open_on_start = true, close_on_exit = false },
          #       builder = function()
          #         local basename = vim.fn.expand("%:r")
          #         return {
          #           cmd = { "./" .. basename },
          #         }
          #       end,
          #       condition = { filetype = { "cpp" } },
          #       tags = { "run" },
          #     })
          #
          #     vim.keymap.set("n", "<leader>b", function()
          #       overseer.run_template({ tags = { "build" } })
          #     end, { desc = "Run build task" })
          #     
          #     vim.keymap.set("n", "<leader>r", function()
          #       overseer.run_template({ tags = { "run" } })
          #     end, { desc = "Run run task" })
          #   '';
          # };
        };

        luaConfigRC.make = ''
          local function term_exec(cmd)
            require("toggleterm") -- in case of lazy loading
            if vim.env.TMUX ~= nil then
              local tmux_cmd = string.format('tmux send-keys -t 1 "%s" C-m', cmd)
              vim.fn.system(tmux_cmd)
            else
              local Terminal = require("toggleterm.terminal").Terminal
              local term = Terminal:new({
                cmd = string.format("bash -c '%s; exec bash'", cmd),
                go_back = 0,
                direction = "horizontal",
                close_on_exit = true,
              })
              term:toggle()
            end
          end

          local function term_build(cmd)
            if vim.env.TMUX ~= nil then
              local tmux_cmd = string.format('tmux send-keys -t 1 "%s" C-m', cmd)
              vim.fn.system(tmux_cmd)
            else
              vim.api.nvim_command('! ' .. cmd)
            end
          end

          local build_functions = {
            cpp = function()
              local filename = vim.fn.expand('%:p')
              local output_filename = vim.fn.expand('%:p:r')
              local command = string.format(
                '${pkgs.gcc}/bin/g++ -DLOCAL -include ${config.home.terminal.tools.precomp-bits.out}/stdc++.h -Wall -Wextra "%s" -o "%s"',
                filename,
                output_filename
              )
              term_build(command)
            end,
          }

          local run_functions = {
            cpp = function()
              local cmd = vim.fn.expand('%:p:r')
              term_exec(cmd)
            end,
            python = function()
              local cmd = 'python ' .. vim.fn.expand('%:p')
              term_exec(cmd)
            end,
          }

          local function check_script(script)
            local f = io.open(script, 'r')
            if f == nil then
              return false
            end
            io.close(f)
            return true
          end

          local function run_from_script(script)
            term_exec(script)
          end

          local function build_from_script(script)
            term_exec(script)
          end

          local function run_program()
            local shell_script = vim.fn.getcwd() .. '/run.sh'
            if check_script(shell_script) then
              run_from_script(shell_script)
              return
            end

            local filetype = vim.bo.filetype

            if run_functions[filetype] then
              run_functions[filetype]()
            else
              print("No run function defined for filetype: " .. filetype)
            end
          end

          local function build_program()
            local shell_script = vim.fn.getcwd() .. '/build.sh'
            if check_script(shell_script) then
              build_from_script(shell_script)
              return
            end

            local filetype = vim.bo.filetype

            if build_functions[filetype] then
              build_functions[filetype]()
            else
              print("No build function defined for filetype: " .. filetype)
            end
          end

          vim.keymap.set('n', '<leader>b', build_program, { desc = 'Make | Build Program', silent = true })
          vim.keymap.set('n', '<leader>r', run_program, { desc = 'Make | Run Program', silent = true })
        '';

        preventJunkFiles = true;

        viAlias = true;
        vimAlias = true;

        searchCase = "smart";

        options = {
          scrolloff = 5;
          termguicolors = true;
          cursorline = true;

          undofile = true;

          expandtab = true;
          shiftwidth = 4;
          tabstop = 4;
          smartindent = true;

          wrap = false;
        };

        luaConfigRC.shortmess = ''
          vim.opt.shortmess:append("I")
        '';

        globals = {
          mapleader = " ";
          netrw_bufsettings = "noma nomod nu nobl nowrap ro";
        };

        lsp = {
          enable = true;
          otter-nvim.enable = true;

          mappings = {
            hover = "<leader>lk";
            goToDefinition = "<leader>ld";
            goToDeclaration = "<leader>lD";
            listImplementations = "<leader>li";
            goToType = "<leader>lo";
            listReferences = "<leader>lr";
            signatureHelp = "<leader>ls";
            renameSymbol = "<leader>lR";
            format = "<leader>lf";
            codeAction = "<leader>la";
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          assembly.enable = true;
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          haskell.enable = true;
          html.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python = {
            enable = true;
            lsp.server = "pyright";
          };
          tailwind.enable = true;
          ts.enable = true;
        };

        diagnostics.config = {
          virtual_lines.enable = true;
          virtual_text.enable = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;
        };

        statusline.lualine = {
          enable = true;

          activeSection.a = [
            ''
              {
                "mode",
                icons_enabled = true,
                separator = {
                  left = "",
                  right = ''
                },
              }
            ''
            ''
              {
                "",
                draw_empty = true,
                separator = { left = '', right = '' }
              }
            ''
          ];

          activeSection.b = [
            ''
              {
                "filetype",
                colored = true,
                icon_only = true,
                icon = { align = 'left' }
              }
            ''
            ''
              {
                "filename",
                symbols = {modified = '*', readonly = ' '},
                separator = {right = ''}
              }
            ''
            ''
              {
                "",
                draw_empty = true,
                separator = { left = '', right = '' }
              }
            ''
          ];
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          mappings = {
            confirm = null;
            next = null;
            previous = null;
            complete = null;
            close = null;
            scrollDocsUp = null;
            scrollDocsDown = null;
          };

          setupOpts = {
            completion = {
              documentation.auto_show = false;
              menu.auto_show = false;
            };

            keymap = {
              preset = "none";
              "<C-k>" = [ "show" "select_prev" "fallback" ];
              "<C-j>" = [ "show_and_insert" "select_next" "fallback" ];
              "<C-m>" = [ "accept" "fallback" ];
              "<Tab>" = [ "accept" "snippet_forward" "fallback" ];
              "<S-Tab>" = [ "snippet_backward" "fallback" ];
              "<C-l>" = [ "show_signature" "fallback" ];
            };

            signature = {
              enabled = true;

              trigger = {
                show_on_insert = false;
                show_on_keyword = false;
                show_on_trigger_character = false;
                show_on_insert_on_trigger_character = false;
              };

              window = {
                show_documentation = true;
              };
            };
          };
        };

        snippets.luasnip.enable = true;

        utility = {
          undotree.enable = true;

          images = {
            img-clip.enable = true;
          };
        };

        notes = {
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            setupOpts.winbar.enabled = false;
          };
        };

        comments = {
          comment-nvim.enable = true;
        };

        ui = {
          fastaction.enable = true;
        };

        telescope.enable = true;

        luaConfigRC.telescope = ''
          local telescope = require('telescope')
          local telescope_actions = require('telescope.actions')
          telescope.setup {
            defaults = {
              mappings = {
                i = {
                  ['<C-k>'] = telescope_actions.move_selection_previous,
                  ['<C-j>'] = telescope_actions.move_selection_next,
                }
              }
            }
          }
        '';

        navigation.harpoon = {
          enable = true;
          mappings = {
            listMarks = "<leader>hm";
            markFile = "<leader>ha";
          };
        };

        luaConfigRC.harpoon = ''
          local harpoon = require("harpoon")
  
          for i = 1, 9 do
            vim.keymap.set(
              "n", "<leader>" .. tostring(i),
              function() harpoon:list():select(11 - i) end,
              { silent = true }
            )
          end

          vim.keymap.set("n", "<leader>0", function() harpoon:list():select(1) end, { silent = true })
        '';

        keymaps = [
          # Yank/Delete all text
          { key = "<leader>d%"; action = ": %d<CR>"; mode = "n"; silent = true; desc = "General | Delete all text"; }
          { key = "<leader>y%"; action = ": %y+<CR>"; mode = "n"; silent = true; desc = "General | Yank all text"; }

          # Inverse tab
          { key = "<S-Tab>"; action = "<C-d>"; mode = "i"; silent = true; desc = "General | Inverse tab"; }

          # Better J
          { key = "J"; action = "mzJ`z"; mode = "n"; silent = true; desc = "General | Better J"; }

          # Half-page jumping
          { key = "<C-d>"; action = "<C-d>zz"; mode = "n"; silent = true; desc = "General | Better half-page down"; }
          { key = "<C-u>"; action = "<C-u>zz"; mode = "n"; silent = true; desc = "General | Better half-page up"; }

          # Search centering
          { key = "n"; action = "nzzzv"; mode = "n"; silent = true; desc = "General | Better search next"; }
          { key = "N"; action = "Nzzzv"; mode = "n"; silent = true; desc = "General | Better search previous"; }

          # Better paste
          { key = "p"; action = "\"_dP"; mode = "v"; silent = true; desc = "General | Better paste"; }

          # Clipboard
          { key = "<leader>y"; action = "\"+y"; mode = ["n" "v"]; silent = true; desc = "General | Yank to system clipboard"; }
          { key = "<leader>Y"; action = "\"+Y"; mode = "n"; silent = true; desc = "General | Yank to system clipboard"; }

          # Delete without yanking
          { key = "<leader>d"; action = "\"_d"; mode = "n"; silent = true; desc = "General | Delete without yanking"; }
          { key = "<leader>d"; action = "\"_d"; mode = "v"; silent = true; desc = "General | Delete without yanking"; }

          # Indentation
          { key = "<"; action = "<gv"; mode = "v"; silent = true; desc = "General | Indent backward"; }
          { key = ">"; action = ">gv"; mode = "v"; silent = true; desc = "General | Indent forward"; }

          # Terminal
          { key = "<Esc>"; action = "<C-\\><C-n>"; mode = "t"; silent = true; desc = "General | Enter Insert Mode"; }

          # Messages + Health
          { key = "<leader>nm"; action = ":messages<CR>"; mode = "n"; silent = true; desc = "Neovim | Messages"; }
          { key = "<leader>nh"; action = ":checkhealth<CR>"; mode = "n"; silent = true; desc = "Neovim | Health"; }

          # Quickfix
          { key = "<leader>k"; action = ":cnext<CR>zz"; mode = "n"; silent = true; desc = "General | Quickfix next"; }
          { key = "<leader>j"; action = ":cprev<CR>zz"; mode = "n"; silent = true; desc = "General | Quickfix prev"; }
          { key = "<leader>K"; action = ":lnext<CR>zz"; mode = "n"; silent = true; desc = "General | Quickfix next (loclist)"; }
          { key = "<leader>J"; action = ":lprev<CR>zz"; mode = "n"; silent = true; desc = "General | Quickfix prev (loclist)"; }

          # Netrw
          { key = "<leader>nF"; action = ":Ex<CR>"; mode = "n"; silent = true; desc = "Neovim | Open netrw to top"; }

          # Toggle terminal
          { key = "<leader>nt"; action = ":ToggleTerm<CR>"; mode = "n"; silent = true; desc = "General | Toggle Terminal"; }

          # Marks
          { key = "<leader>m"; action = "`"; mode = "n"; silent = true; desc = "General | Marks shortcut"; }

          # Clear search highlights
          { key = "<C-l>"; action = ":nohl<CR>"; mode = "n"; silent = true; }
        ];

        luaConfigRC.motion_keymaps = ''
          -- Move text down in visual mode
          vim.keymap.set('v', 'J', function()
            local count = vim.v.count == 0 and 1 or vim.v.count
            return ":m '>+" .. count .. "<CR>gv=gv"
          end, { desc = 'General | Move the selected text down', silent = true, expr = true })

          -- Move text up in visual mode
          vim.keymap.set('v', 'K', function()
            local count = (vim.v.count == 0 and 1 or vim.v.count) + 1
            return ":m '<-" .. count .. "<CR>gv=gv"
          end, { desc = 'General | Move the selected text up', silent = true, expr = true })

          -- Better J (keep cursor in place)
          vim.keymap.set('n', 'J', ':keepjumps normal! J<CR>', { desc = 'General | Better J', silent = true })

          -- Append/insert should match indentation level
          local function match_line(action)
            local line = vim.fn.getline('.')
            if #line == 0 or line:match('^%s+$') then
              return 'cc' -- empty line: change line
            else
              return action -- not empty: proceed as normal
            end
          end

          vim.keymap.set('n', 'i', function() return match_line('i') end, { desc = 'General | Improved insert', silent = true, expr = true })
          vim.keymap.set('n', 'a', function() return match_line('a') end, { desc = 'General | Improved append', silent = true, expr = true })
        '';

        luaConfigRC.netrw_keymaps = ''
          -- netrw: open with cursor on current file
          vim.keymap.set('n', '<leader>nf', function()
            local cur_file = vim.fn.expand('%:t')
            vim.cmd.Ex()
            local starting_line = 8 -- first file line
            local lines = vim.api.nvim_buf_get_lines(0, starting_line, -1, false)
            for i, file in ipairs(lines) do
              if file:find(cur_file, 1, true) then
                vim.api.nvim_win_set_cursor(0, { starting_line + i, 0 })
                return
              end
            end
          end, { desc = 'Neovim | Open netrw to current file', silent = true })
        '';

        autocmds = [
          # Set tab to 2 spaces, instead of the default 4
          {
            event = [ "FileType" ];
            pattern = [ "javascript" "typescript" "html" "css" "nix" "typescriptreact" "javascriptreact" ];
            desc = "Set tab to 2 spaces for certain filetypes";
            command = "setlocal tabstop=2 shiftwidth=2 expandtab";
          }
        ];

        luaConfigRC.lsp_BS = ''
          vim.diagnostic.config({
            virtual_text = {
              spacing = 2,
              prefix = "•"
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true
          })
        '';

        luaConfigRC.theme = ''
          local function fix_floats()
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = vim.g.base16_gui01 })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = vim.g.base16_gui04, bg = vim.g.base16_gui01 })
          end
          fix_floats()

          vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
            callback = fix_floats
          })
        '';
      };
    };
  };
}
