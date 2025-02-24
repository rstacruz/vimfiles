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
      { "<leader>!i", desc = "+aider" },
      { "<leader>!it", "<cmd>AiderTerminalToggle<cr>", desc = "Aider: Open Terminal" },
      { "<leader>!il", "<cmd>AiderTerminalSend<cr>", desc = "Aider: Send", mode = { "n", "v" } },
      { "<leader>!ik", "<cmd>AiderQuickSendCommand<cr>", desc = "Aider: Send Command" },
      {
        "<leader>!ix",
        "<cmd>AiderQuickSendCommand /clear<cr><cmd>AiderQuickSendCommand /drop<cr>",
        desc = "Aider: reset",
      },
      { "<leader>!ij", "<cmd>AiderQuickSendBuffer<cr>", desc = "Aider: Send Buffer" },
      { "<leader>!i+", "<cmd>AiderQuickAddFile<cr>", desc = "Aider: Add File" },
      { "<leader>!i-", "<cmd>AiderQuickDropFile<cr>", desc = "Aider: Drop File" },
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
