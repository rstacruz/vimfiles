-- Overrides:
-- These are plugins that are included in LazyVim. They're defined in this files
-- to override some settings.

local is_vscode = vim.g.vscode or vim.env.VSCODE
local uname = vim.loop.os_uname()
local is_android = uname.machine == "aarch64"
-- uname.sysname = "Darwin" | "Linux"
-- uname.arch = "aarch64" (Android) | "arm64" (Mac) | "x86_64"

return {
  { -- nvim-cmp
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  { -- flash
    "folke/flash.nvim",
    opts = {
      -- Colemak labels
      labels = "arstdhneiogmvkzxcqwfpbjluy",

      label = {
        -- Make labels bigger
        format = function(opts)
          return { { " " .. opts.match.label .. " ", opts.hl_group } }
        end,
      },

      modes = {
        char = {
          -- disable `f F t T ; ,` motions
          enabled = false,
        },
      },
    },

    -- remove `s` `r` `R` `c-s` keys
    keys = {
      {
        "S",
        mode = { "n" }, --, "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Select block... (flash treesitter)",
      },
      {
        "fw",
        -- yeah, now we can't do `f w` to look for "w" anymore lol. but do i ever do that? probably not
        mode = { "n", "o", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Jump to... (flash)",
      },
    },
  },

  { -- nvim-treesitter
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
        "astro",
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        -- mdx
        -- https://www.devas.life/effective-neovim-setup-for-web-development-towards-2024/#treesitter
        -- https://joschua.io/posts/2023/06/22/set-up-nvim-for-astro/
        -- not working though :(
        vim.filetype.add({ extension = { mdx = "mdx" } })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },
  },

  { -- Telescope
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "Recent" },
    },
  },

  { -- bufferline
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

  -- { -- surround: remove
  --   "echasnovski/mini.surround",
  --   enabled = false,
  -- },

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

  { -- nvim-lspconfig
    "neovim/nvim-lspconfig",
    enabled = not is_vscode,
    opts = {
      -- diagnostics = {
      --   virtual_text = false, -- let lsp-lines handle it
      -- },
      servers = {
        lua_ls = {
          mason = not is_android,
        },
      },
    },
  },

  { -- Luasnip snippets
    "L3MON4D3/LuaSnip",
    enabled = not is_vscode,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
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

  -- { -- Indentscope
  --   -- Remove animations
  --   "echasnovski/mini.indentscope",
  --   enabled = not is_vscode,
  --   opts = {
  --     draw = {
  --       delay = 0, -- default: 100
  --       animation = require("mini.indentscope").gen_animation.none(),
  --     },
  --   },
  -- },

  { -- Spectre
    -- Opens in insert mode
    "nvim-pack/nvim-spectre",
    enabled = not is_vscode,
    opts = {
      line_sep_start = "",
      result_padding = "   ",
      line_sep = "",
      find_engine = {
        ["rg"] = {
          -- add hidden
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--hidden" },
        },
      },
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
      { "-", "<cmd>Neotree filesystem reveal float<cr>", { desc = "Reveal file in Neotree" } },
      { "<leader>gS", "<cmd>Neotree git_status float<cr>", { desc = "Git status in Neotree" } },
    },
    opts = function(_, opts)
      opts.position = "current"
      opts.event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      }
    end,
  },

  { -- Mason
    "williamboman/mason.nvim",
    enabled = not is_vscode,
    opts = {
      ensure_installed = uname.arch == "aarch64" and {} or {
        "stylua",
        "css-lsp",
        -- "deno",
        "eslint-lsp",
        "prettier",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        -- "vtsls",
        "typescript-language-server",
      },
    },
  },
}
