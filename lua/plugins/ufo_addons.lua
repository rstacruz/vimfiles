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

-- https://github.com/kevinhwang91/nvim-ufo/blob/main/doc/example.lua#L3
local function provider_selector(_, filetype, _) -- bufnr, filetype, buftype
  local filetypes = {
    vim = "indent",
    python = { "indent" },
    markdown = { "treesitter" },
    git = "",
  }
  -- custom -> lsp -> indent
  return filetypes[filetype]

  -- custom -> treesitter -> indent
  -- return filetypes[filetype] or {'treesitter', 'indent'}
end

local function ufo_next_fold()
  require("ufo").goNextClosedFold()
  vim.schedule(function()
    require("ufo").peekFoldedLinesUnderCursor()
  end)
end
local function ufo_prev_fold()
  require("ufo").goPreviousClosedFold()
  vim.schedule(function()
    require("ufo").peekFoldedLinesUnderCursor()
  end)
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
      provider_selector = provider_selector,
    },
    -- stylua: ignore
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds", },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds", },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Increase fold level", },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Reduce fold level", },
      { "zj", ufo_next_fold, desc = "UFO: Peek next fold", },
      { "zk", ufo_prev_fold, desc = "UFO: Peek prev fold", },
      { "[z", ufo_prev_fold, desc = "UFO: Peek prev fold", },
      { "]z", ufo_next_fold, desc = "UFO: Peek next fold", },
    },
    config = function(_, opts)
      vim.o.foldlevel = 999
      vim.o.foldlevelstart = 999
      vim.o.foldcolumn = "1"
      require("ufo").setup(opts)
    end,
  },
}

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
