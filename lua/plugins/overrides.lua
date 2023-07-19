-- Overrides:
-- These are plugins that are included in LazyVim. They're defined in this files
-- to override some settings.

local is_vscode = vim.g.vscode or vim.env.VSCODE
local uname = vim.loop.os_uname()
-- uname.sysname = "Darwin" | "Linux"
-- uname.arch = "aarch64" (Android) | "arm64" (Mac) | "x86_64"

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        -- Required for spellcheck, some LaTex highlights and
        -- code block highlights that do not have ts grammar
        additional_vim_regex_highlighting = { "org" },
      },
      ensure_installed = {
        -- default:
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        -- added:
        "org",
      },
    },
  },

  { -- indent guides for Neovim
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏", -- from lazyvim: "│",

      -- add neorg and org
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "neorg", "org" },
    },
  },

  { -- Telescope
    -- Updates borders to look more minimal
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- prompt_prefix = "   ",
        prompt_prefix = "  ",
        selection_caret = "› ",
        entry_prefix = "  ",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        -- borderchars = { " ", "▕", "▁", "▏", "▏", "▕", "🭿", "🭼" },
        -- borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
      },
    },
  },

  -- { -- leap: disable
  --   "ggandor/leap.nvim",
  --   enabled = false,
  -- },

  { -- bufferline:
    -- add `leader-bo` to isolate buffers
    "akinsho/bufferline.nvim",
    enabled = not is_vscode,
    keys = {
      {
        "<leader>bo",
        "<cmd>BufferLineTogglePin<cr>:BufferLineGroupClose ungrouped<cr>:BufferLineTogglePin<cr>",
        desc = "Delete other buffers",
      },
    },
  },

  { -- surround: remove
    "echasnovski/mini.surround",
    enabled = false,
  },

  { -- lualine: simplify lualine
    "nvim-lualine/lualine.nvim",
    enabled = not is_vscode,
    opts = function(_, opts)
      opts.sections.lualine_a = {} -- vim mode
      opts.sections.lualine_b = {} -- branch
      opts.sections.lualine_z = {} -- time
      return opts
    end,
  },

  { -- Telescope
    "nvim-telescope/telescope.nvim",
    enabled = not is_vscode,
    keys = {
      { "<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "Recent" },
    },
  },

  { -- nvim-lspconfig
    "neovim/nvim-lspconfig",
    enabled = not is_vscode,
    opts = {
      diagnostics = {
        virtual_text = false, -- let lsp-lines handle it
      },
    },
  },

  { -- null-ls: add prettier
    "jose-elias-alvarez/null-ls.nvim",
    enabled = not is_vscode,
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- See `:Mason` then `(5) formatter` for formatters,
          -- and `(4) linter` for diagnostics
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          -- nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return utils.root_has_file("node_modules/prettier/package.json")
              -- return utils.root_has_file_matches(".prettierrc*") or utils.root_has_file_matches("prettier.config.*")
            end,
          }),
        },
      }
    end,
  },

  { -- Luasnip snippets
    "L3MON4D3/LuaSnip",
    enabled = not is_vscode,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
    end,
  },

  { -- Noice
    "folke/noice.nvim",
    enabled = not is_vscode,
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  { -- Notify
    -- Makes things more minimal and less intrusive
    "rcarriga/nvim-notify",
    enabled = not is_vscode,
    opts = {
      render = "minimal", -- default: "default"
      stages = "static", -- default: "fade_in_slide_out"
      top_down = true, -- shows at the bot. default: true
      max_width = function() -- default: columns * 0.75
        return math.floor(vim.o.columns * 0.5)
      end,
    },
  },

  { -- Pairs
    -- I just don't like autopairs, that's all
    "echasnovski/mini.pairs",
    enabled = false,
  },

  { -- Indentscope
    -- Remove animations
    "echasnovski/mini.indentscope",
    enabled = not is_vscode,
    opts = {
      draw = {
        delay = 0, -- default: 100
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },

  { -- Spectre
    -- Opens in insert mode
    "windwp/nvim-spectre",
    enabled = not is_vscode,
    opts = {
      line_sep_start = "",
      result_padding = "   ",
      line_sep = "",
    },
    keys = {
      { -- Updates options passed to open()
        "<leader>sr",
        function()
          require("spectre").open({ is_insert_mode = true })
        end,
        desc = "Replace in files (Spectre)",
      },
      { -- new
        "<leader>s*",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  { -- Flit
    -- Rebinds `f F t T` to be leap-like. I can never get used to it :(
    "ggandor/flit.nvim",
    enabled = false,
  },

  { -- Neotree
    -- Changes key mappings
    "nvim-neo-tree/neo-tree.nvim",
    enabled = not is_vscode,
    keys = {
      { "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Neotree" } },
      -- ^ Focus instead of toggle
    },
  },

  { -- Alpha (welcome page)
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L227-L239
    "goolord/alpha-nvim",
    enabled = not is_vscode,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "┌──┬──────────────────────────────────────────────┐",
        "├──┴──────────────────────────────────────────────┤",
        "│                                                 │",
        "│   Microsoft® Visual Studio Code™        ┌─┐     │",
        "│   Version 0.9, MS-DOS Edition          ⊙␣⊙│     │",
        "│                                         │ ││    │",
        "│   Copyright © 1991, Microsoft           │─┘│    │",
        "│   Corporation. All rights reserved.     └──┘    │",
        "│                                                 │",
        "└─────────────────────────────────────────────────┘",
      }
      dashboard.section.buttons.val = {
        dashboard.button("s", "󰑓 " .. " RESUME.EXE", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("n", " " .. " NEWFILE.BAT", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", " " .. " FIND.EXE", ":Telescope find_files <CR>"),
        dashboard.button("r", " " .. " RECENTS.EXE", ":Telescope oldfiles only_cwd=true<CR>"),
        dashboard.button("m", " " .. " MARKS.COM", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"),
        dashboard.button("q", " " .. " CTRLALT.DEL", ":qa<CR>"),
        -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      }
      return dashboard
    end,
  },

  { -- Mason
    "williamboman/mason.nvim",
    enabled = not is_vscode,
    opts = {
      ensure_installed = uname.arch == "aarch64" and {} or {
        "stylua",
        "css-lsp",
        "deno",
        "eslint-lsp",
        "prettierd",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
}
