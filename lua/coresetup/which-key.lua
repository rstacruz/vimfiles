local function setup()
  local has, which_key = pcall(require, "which-key")
  if not has then
    return
  end

  local options = {
    window = {
      border = "none",
    },
    layout = {
      spacing = 6,
    },
    icons = {
      breadcrumb = "›", -- in the command line area
      separator = "", -- between a key and it's label
      group = " ",
    },
  }
  which_key.setup(options)
end

return { setup = setup }
