return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    opts = function(_, opts)
      opts.prompts = {
        cz = {
          prompt = "generate a commit message in commitizen format.",
        },
      }
      return opts
    end,
  },
}
