-- local function update_eyeliner_hlconfig()
--   vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
--   vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true })
-- end
--
-- local function setup_autocmd()
--   vim.api.nvim_create_autocmd("Colorscheme", {
--     pattern = "*",
--     group = vim.api.nvim_create_augroup("customise_eyeliner", { clear = true }),
--     callback = function()
--       update_eyeliner_hlconfig()
--     end,
--   })
-- end

return {
  "jinh0/eyeliner.nvim",
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("eyeliner").setup(opts)
    -- setup_autocmd()
    -- update_eyeliner_hlconfig()
  end,
}
