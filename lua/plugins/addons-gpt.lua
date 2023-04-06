-- Addons: GPT
-- Plugins that aren't part of LazyVim. THese are OpenAI related plugins
local has_gpt_key = os.getenv("OPENAI_API_KEY") ~= nil

return {
  { -- chatgpt
    -- <c-s> to submit prompt
    -- <c-y> copy last answer
    -- <c-k> copy last answer (code)
    "jackMort/ChatGPT.nvim",
    opts = {
      keymaps = {
        submit = "<C-s>",
      },
    },
    enabled = has_gpt_key,
    config = function(_, opts)
      require("chatgpt").setup(opts)
    end,
    keys = {
      { "<leader>!c", "<cmd>ChatGPT<cr>", desc = "Open ChatGPT" },
    },
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  { -- codegpt
    -- (visual) :Chat tests -- write tests
    -- (visual) :Chat explain -- explain selection
    -- (visual) :Chat opt -- optimise
    "dpayne/CodeGPT.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    enabled = has_gpt_key,
    keys = {
      { "<leader>!Cx", "<cmd>ChatGPT explain<cr>", desc = "Explain this", mode = "v" },
      { "<leader>!Co", "<cmd>ChatGPT opt<cr>", desc = "Optimise this", mode = "v" },
      { "<leader>!Ct", "<cmd>ChatGPT test<cr>", desc = "Write tests for this", mode = "v" },
    },
    config = function()
      require("codegpt.config")
    end,
  },
}
