local function get_prefills()
  local cwd = vim.fn.getcwd()
  local is_vault = string.find(cwd, "Vault") ~= nil
  local files_filter = is_vault and "!*ZZ*" or ""
  return { flags = "-S", filesFilter = files_filter }
end

return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      -- when enabled, grug-far overrides `foldexpr` globally which breaks folding
      options = { folding = { enabled = false } },
    },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>s*",
        function()
          local grug = require("grug-far")
          local word = vim.fn.expand("<cword>")
          local prefills = get_prefills()
          prefills.search = word

          -- https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
          grug.open({
            prefills = prefills,
            engines = {
              ripgrep = {
                placeholders = { enabled = false },
              },
            },
          })
        end,
        desc = "Search for word",
      },
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          grug.open({
            prefills = get_prefills(),
            engines = {
              ripgrep = {
                placeholders = { enabled = false },
              },
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
