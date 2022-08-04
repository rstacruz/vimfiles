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

-- Open git files, fall back to find files
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local function open_file_picker()
  local ok = pcall(require("telescope.builtin").git_files)
  if not ok then require("telescope.builtin").find_files() end
end

return {
  open_tig = open_tig,
  open_floating_cmd = open_floating_cmd,
  telescope_grep = telescope_grep,
  open_file_picker = open_file_picker
}
