-- https://github.com/kevinhwang91/nvim-ufo#customize-fold-text
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("[%d]"):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { " …  ", "Comment" })
  table.insert(newVirtText, { suffix, "DiagnosticOk" }) -- MoreMsg
  return newVirtText
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
      fold_virt_text_handler = handler,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
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
