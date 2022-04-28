local function open_floating_cmd(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({ cmd = cmd, direction = "float" }):toggle()
end

local function open_tig()
  open_floating_cmd("tig")
end

-- Live grep via telescope
local function telescope_grep()
  local opts = require("telescope.themes").get_ivy({ previewer = false })
  require("telescope.builtin").live_grep(opts)
end

-- Show a reference of key bindings
local function show_reference()
  require("legendary").find(nil, {
    require("legendary.filters").mode("n"),
    function(item)
      if not string.find(item.kind, "keymap") then
        return true
      end
      return vim.startswith(item[1], "<Leader>")
    end,
  })
end

return {
  open_tig = open_tig,
  open_floating_cmd = open_floating_cmd,
  telescope_grep = telescope_grep,
  show_reference = show_reference,
}
