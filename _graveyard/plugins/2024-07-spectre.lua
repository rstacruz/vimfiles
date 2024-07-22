return {
  { -- Spectre
    -- Opens in insert mode
    "nvim-pack/nvim-spectre",
    enabled = not is_vscode,
    opts = {
      line_sep_start = "",
      result_padding = "   ",
      line_sep = "",
      find_engine = {
        ["rg"] = {
          -- add hidden
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--hidden" },
        },
      },
    },
    keys = {
      { -- Updates options passed to open()
        "<leader>sr",
        function()
          require("spectre").open({ is_insert_mode = true })
        end,
        desc = "Replace in files (Spectre)",
      },
      { -- new
        "<leader>s*",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace in files (Spectre)",
      },
    },
}
