return {
  { -- Neotree
    -- Changes key mappings
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "-", "<cmd>Neotree filesystem reveal float<cr>", { desc = "Reveal file in Neotree" } },
    },
    opts = function(_, opts)
      opts.position = "current"
      opts.event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      }
    end,
  },
}
