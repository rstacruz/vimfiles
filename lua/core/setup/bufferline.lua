local function setup()
  local has, bufferline = pcall(require, "bufferline")
  if not has then
    return
  end

  local has_groups, groups = pcall(require, "bufferline.groups")

  bufferline.setup({
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = function()
            return "" -- vim.fn.getcwd()
          end,
          highlight = "NvimTreeNormal",
          text_align = "left",
        },
      },
      separator_style = "slant", -- slant | thick | thin
      diagnostics = "nvim_lsp",
      -- diagnostics_indicator = function(count, level)
      --   local icon = level:match("error") and "" or ""
      --   return " " .. icon .. count
      -- end,
      groups = has_groups
          and {
            options = {
              toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
            },
            items = {
              groups.builtin.ungrouped,
              {
                name = "Docs",
                matcher = function(buf)
                  return buf.filename:match("%.md") or buf.filename:match("%.txt")
                end,
              },
            },
          },
    },
  })
end

return { setup = setup }
