local uname = vim.loop.os_uname()
-- uname.sysname = "Darwin" | "Linux"
-- uname.arch = "aarch64" (Android) | "arm64" (Mac) | "x86_64"

return {
  { -- Luasnip snippets
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
    end,
  },

  { -- Noice
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  { -- Notify
    -- Makes things more minimal and less intrusive
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal", -- default: "default"
      stages = "fade", -- default: "fade_in_slide_out"
      top_down = false, -- shows at the bot. default: true
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
    keys = {
      { "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Neotree" } },
      -- ^ Focus instead of toggle
    },
  },

  { -- Alpha (welcome page)
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L227-L239
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = { "Neovim" }
      dashboard.section.buttons.val = {
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        -- dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        -- dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        -- dashboard.button("s", "󰑓 " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      }
      return dashboard
    end,
  },

  { -- Mason
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = uname.arch == "aarch64" and {} or {
        "stylua",
        "shellcheck",
        "shfmt",
        "prettierd",
        "css-lsp",
        "tailwindcss-language-server",
      },
    },
  },
}
