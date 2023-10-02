return {
  { -- Neorg: note taking
    -- I don't use this much, just giving this a try (Apr 2023)
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = true,
    ft = { "neorg", "norg" },
    cmd = { "Neorg" },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        -- meta-enter will continue lists and headings
        -- https://github.com/nvim-neorg/neorg/wiki/Itero
        ["core.itero"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "basic", -- basic | diamond | varied
          },
        }, -- Adds pretty icons to your documents
        -- ["core.norg.dirman"] = { -- Manages Neorg workspaces
        --   config = {
        --     workspaces = {
        --       notes = "~/notes",
        --     },
        --   },
        -- },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
