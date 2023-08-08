return {
  { -- Harpoon
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = {
      {
        "<leader>!fm",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Edit marks... (harpoon)",
      },
      {
        "<leader>fm",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "Show marks... (harpoon)",
      },
      {
        "<leader>fM",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark this file (harpoon)",
      },
    },
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },
}
