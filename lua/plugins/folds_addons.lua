-- https://github.com/kevinhwang91/nvim-ufo#customize-fold-text
-- https://github.com/rafi/vim-config/blob/6b2b2d96697ad282d554eb2105f0278dd05fbcb0/lua/rafi/plugins/extras/editor/ufo.lua#L4
local fold_virt_text_handler = function(text, lnum, endLnum, width)
  local suffix = " 󰇘 "
  local lines = (" %d 󰁂 "):format(endLnum - lnum)

  local cur_width = 0
  for _, section in ipairs(text) do
    cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
  end

  suffix = suffix .. (" "):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

  table.insert(text, { suffix, "DiagnosticOk" }) -- Comment, UfoFoldedEllipsis
  table.insert(text, { lines, "DiagnosticOk" })
  return text
end

return {
  { -- ufo: better folds
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      fold_virt_text_handler = fold_virt_text_handler,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds!",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      -- {
      --   "zr",
      --   function()
      --     require("ufo").openFoldsExceptKinds()
      --   end,
      --   desc = "Increase fold level",
      -- },
      -- {
      --   "zm",
      --   function()
      --     require("ufo").closeFoldsWith()
      --   end,
      --   desc = "Reduce fold level",
      -- },
      {
        "zk", -- "[z",
        function()
          require("ufo").goPreviousClosedFold()
          vim.schedule(function()
            require("ufo").peekFoldedLinesUnderCursor()
          end)
        end,
        desc = "UFO: Peek prev fold",
      },
      {
        "zj", -- "]z"
        function()
          require("ufo").goNextClosedFold()
          vim.schedule(function()
            require("ufo").peekFoldedLinesUnderCursor()
          end)
        end,
        desc = "UFO: Peek next fold",
      },
      -- {
      --   "K",
      --   function()
      --     local winid = require("ufo").peekFoldedLinesUnderCursor()
      --     if not winid then
      --       vim.lsp.buf.hover()
      --     end
      --   end,
      --   desc = "Peek",
      -- },
      -- also see: https://github.com/LazyVim/LazyVim/discussions/1881#discussioncomment-7395199
    },
  },

  -- { -- Origami
  --   -- `^ h` to fold (h at first non-blank char)
  --   -- `l` to unfold
  --   "chrisgrieser/nvim-origami",
  --   lazy = true,
  --   event = "BufReadPost",
  --   opts = true,
  -- },

  -- { -- pretty fold
  --   "anuvyklack/pretty-fold.nvim",
  --   lazy = true,
  --   event = { "BufReadPost" },
  --   enabled = not is_vscode,
  --   opts = {
  --     fill_char = " ",
  --   },
  --   config = function(_, opts)
  --     require("pretty-fold").setup(opts)
  --   end,
  -- },
}
