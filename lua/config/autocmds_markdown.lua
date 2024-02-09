local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("markdown_keybindings", { clear = true }),
    pattern = { "markdown" },
    callback = function(event)
      -- event = { buf, event, file, group, id, match }
      vim.keymap.set("v", "gb", "<cmd>lua vim.notify('hi')<CR>", { buffer = event.buf, desc = "Markdown: bold" })

      -- https://github.com/epwalsh/obsidian.nvim/issues/286
      vim.opt_local.conceallevel = 2
    end,
  })
end

return M
