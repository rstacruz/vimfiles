local function setup()
  local has, scrollview = pcall(require, "scrollview")
  if not has then
    return
  end

  scrollview.setup()
  vim.g.scrollview_excluded_filetypes = { "NvimTree" }
end

return { setup = setup }
