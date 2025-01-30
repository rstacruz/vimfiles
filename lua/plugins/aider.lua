-- https://github.com/LazyVim/LazyVim/pull/5233
if vim.g.disable_ai_plugins == 1 then
  return {}
end

return {
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = { "AiderTerminalToggle" },
    vscode = false,
    keys = {
      { "<leader>Ai", "<cmd>AiderTerminalToggle<cr>", desc = "Aider: Open Terminal " },
      { "<leader>Al", "<cmd>AiderTerminalSend<cr>", desc = "Aider: Send", mode = { "n", "v" } },
      { "<leader>Ak", "<cmd>AiderQuickSendCommand<cr>", desc = "Aider: Send Command" },
      { "<leader>Aj", "<cmd>AiderQuickSendBuffer<cr>", desc = "Aider: Send Buffer" },
      { "<leader>A+", "<cmd>AiderQuickAddFile<cr>", desc = "Aider: Add File" },
      { "<leader>A-", "<cmd>AiderQuickDropFile<cr>", desc = "Aider: Drop File" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      win = {
        wo = { winbar = "Aider" },
      },
    },
  },
}
