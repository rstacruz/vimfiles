local function setup_foldexpr()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom_foldexpr", { clear = true }),
    pattern = { "typescript", "javascript", "markdown", "lua", "typescriptreact", "sh" },
    callback = function()
      -- https://github.com/nvim-treesitter/nvim-treesitter#folding
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldenable = false
      vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
  })
end

local KEYS = {
  { "z1", "zM", desc = "Fold everything" },
  { "z2", "<cmd>set foldlevel=1<cr>", desc = "Set foldlevel to 1" },
  { "z3", "<cmd>set foldlevel=2<cr>", desc = "Set foldlevel to 2" },
  { "z4", "<cmd>set foldlevel=3<cr>", desc = "Set foldlevel to 3" },
  { "z5", "<cmd>set foldlevel=4<cr>", desc = "Set foldlevel to 4" },
  { "zU", "zMzv", desc = "Isolate this fold" },
  { "zu", "zMzO", desc = "Isolate and unfold this fold" },
}

return {
  { -- Origami
    -- `h` to fold (at first non-blank char)
    -- `l` to unfold
    -- remember fold across sessions
    -- unfold when searching
    "chrisgrieser/nvim-origami",
    lazy = true,
    event = "BufReadPost",
    opts = true,
  },

  { -- pretty fold
    "anuvyklack/pretty-fold.nvim",
    lazy = true,
    event = { "BufReadPost" },
    opts = {
      fill_char = " ",
      -- Collape `hey(` to `hey( ... )`
      add_close_pattern = false,
      sections = {
        left = { "content", "󰇘 " },
        right = { " 󰁂  ", "number_of_folded_lines" },
      },
    },
    config = function(_, opts)
      setup_foldexpr()
      require("pretty-fold").setup(opts)
    end,
    keys = KEYS,
  },
}
