return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    dependencies = {
      "ibhagwan/fzf-lua", -- no snacks integration for copilotchat yet
    },
    opts = function(_, opts)
      opts.prompts = {
        ai = {
          -- mimics Aider's AI behaviour
          prompt = "#buffer Look for comments in this file marked as AI!. Perform those actions. Then, remove the AI! comment.",
        },
      }
      return opts
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}

      -- Remove what was added by LazyVim (https://www.lazyvim.org/extras/ai/copilot-chat)
      for i, item in ipairs(opts.right) do
        if item.ft == "copilot-chat" then
          table.remove(opts.right, i)
          break
        end
      end

      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 100 },
      })
    end,
  },
}
