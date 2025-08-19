return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for a better input and embedded terminal experience.
      -- To bypass: use your own `toggle` (if any), and override `opts.on_send` and `opts.on_opencode_not_found`.
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    opts = {
      -- Your configuration, if any
    },
    keys = {
      -- stylua: ignore start
      { "<leader>oa", function() require("opencode").ask("@cursor: ") end, desc = "Ask opencode", mode = "n", },
      { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask opencode about selection", mode = "v", },
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode", },
      { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session", },
      { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message", },
      { "<leader>op", function() require("opencode").select_prompt() end, desc = "Select prompt", mode = { "n", "v" }, },
      { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Scroll messages up", },
      { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Scroll messages down", },
      -- stylua: ignore end
    },
  },
}
