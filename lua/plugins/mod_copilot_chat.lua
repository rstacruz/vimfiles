return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    dependencies = {
      "ibhagwan/fzf-lua", -- no snacks integration for copilotchat yet
    },
    opts = function(_, opts)
      opts.model = "claude-3.7-sonnet"
      opts.prompts = {
        AI = {
          -- mimics Aider's AI behaviour
          prompt = ""
            .. "#buffer Are there comments marked AI! or AI?? Perform actions for AI!, answer AI? questions, then delete these comments.",
        },
        AIAll = {
          -- mimics Aider's AI behaviour
          prompt = ""
            .. "#buffers Are there comments marked AI! or AI?? Perform actions for AI!, answer AI? questions, then delete these comments.",
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
        size = { width = 70 },
      })
    end,
  },
}
