local is_termux = string.find(vim.loop.os_uname().release, "android")

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Don't auto install on unsupported platforms
      if is_termux then
        opts.servers.lua_ls.mason = false
      end
    end,
  },
}
