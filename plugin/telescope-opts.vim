if !exists('g:loaded_telescope') | finish | endif

lua << EOF
local success, _ = require('telescope')
if success then
  require('telescope').setup {
    defaults = {
      preview = {
        -- makes previews slow
        treesitter = false
      }
    }
  }
end

EOF
