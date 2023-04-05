local function persist_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

local function close_unused_buffers()
  local curbufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
      vim.cmd("bd " .. tostring(bufnr))
    end
  end
end

local function setup()
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("startup", {
      clear = false,
    }),
    pattern = { "*" },
    callback = function()
      vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
        buffer = 0,
        once = true,
        callback = function()
          persist_buffer()
        end,
      })
    end,
  })
end

return { setup = setup, close_unused_buffers = close_unused_buffers }
