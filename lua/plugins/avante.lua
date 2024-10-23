local is_termux = string.find(vim.loop.os_uname().release, "android")

-- https://github.com/LazyVim/LazyVim/pull/4440
return {
  {
    "yetone/avante.nvim",
    vscode = false,
    enabled = not is_termux,
    init = function()
      require("avante_lib").load()
    end,
    event = "VeryLazy",
    opts = {
      provider = "copilot",
      hints = { enabled = false },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}
