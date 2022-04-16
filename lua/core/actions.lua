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

-- Opens a prompt to switch to a project
local function zed()
  vim.ui.input("Switch to project:", function(value)
    if value == nil then
      return
    end

    vim.cmd("silent! NvimTreeClose")
    vim.cmd("silent! %bw!")
    vim.cmd("Z " .. value)
    vim.cmd("e .")
    -- require("telescope.builtin").oldfiles({ only_cwd = true })
  end)
end

return {
  open_tig = open_tig,
  open_floating_cmd = open_floating_cmd,
  telescope_grep = telescope_grep,
  zed = zed,
}
