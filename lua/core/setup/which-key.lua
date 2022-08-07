local function setup()
  local is_available, which_key = pcall(require, "which-key")
  if not is_available then return end

  which_key.setup({
    window = {
      margin = { 0, 0, 0, 0 },
    },
    key_labels = {
      ["<leader>"] = "∴",
    },
    icons = {
      breadcrumb = "›",
      separator = "┄",
      group = "",
    },
    triggers = { "<leader>" },
    layout = {
      align = "center",
      spacing = 7,
    },
  })
end

return { setup = setup }
