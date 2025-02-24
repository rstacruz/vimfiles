return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    dependencies = {
      "ibhagwan/fzf-lua", -- no snacks integration for copilotchat yet
    },
    opts = function(_, opts)
      opts.prompts = {
        comblock = {
          prompt = "Add comments to mark logical sections in the code. If there are any comments that may be outdated, point them out.",
        },
        tododraft = {
          description = "TODO.md: Lint draft",
          prompt = ""
            .. "#file:CONVENTIONS.md #file:TODO.md #buffers "
            .. "I am drafting a plan for a task in TODO.md. "
            .. "Let me know if the file describes enough info you need. "
            .. "Keep your response brief. "
            .. "Avoid giving code examples, only help with requirements. "
            .. "Try to list down what files and functions may be affected. "
            .. "Do not make any edits to any files other than TODO.md. ",
        },
        todogo = {
          description = "TODO.md: Run todo",
          prompt = "" .. "#file:CONVENTIONS.md #file:TODO.md #buffers Perform the changes listed in TODO.md. ",
        },
        todoclear = {
          description = "TODO.md: clear todo",
          prompt = "" .. "#file:TODO.md " .. "clear out TODO.md, but leave the headings in place.",
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
