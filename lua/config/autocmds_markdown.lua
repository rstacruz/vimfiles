local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("markdown_keybindings", { clear = true }),
    pattern = { "markdown" },
    callback = function(event)
      -- event = { buf, event, file, group, id, match }
      vim.keymap.set(
        "v",
        "gb",
        "gsa*i*<Esc>f*i*<Esc><Right>",
        { buffer = event.buf, desc = "Markdown: bold", remap = true }
      )
      vim.keymap.set("v", "gi", "gsa_", { buffer = event.buf, desc = "Markdown: italic", remap = true })

      -- paste link
      vim.keymap.set(
        "v",
        "g+",
        'gsa]f]a()<Esc><Left>"+p<Right>',
        { buffer = event.buf, desc = "Markdown: paste link", remap = true }
      )

      -- https://github.com/epwalsh/obsidian.nvim/issues/286
      vim.opt_local.conceallevel = 2
    end,
  })
end

return M
