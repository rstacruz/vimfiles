return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    dependencies = {
      "ibhagwan/fzf-lua", -- no snacks integration for copilotchat yet
    },
    opts = function(_, opts)
      opts.prompts = {
        cz = {
          prompt = "generate a commit message in commitizen format.",
        },
        sum = {
          prompt = ""
            .. "Summarise the following message into bullet points. "
            .. "Be terse, concise. "
            .. "Use headings when possible. "
            .. "Try to keep bullet points to 8 words max unless necessary to convey key info.",
        },
      }
      return opts
    end,
  },
}
