local function setup()
	local has, feline = pcall(require, "feline")
	if not has then
		return
	end

  local fileinfo = {
    provider = {
			name = "file_info",
			opts = {
				type = "relative",
				file_readonly_icon = " "
			}
		},
    right_sep = 'slant_right'
  }
	local position = {
		provider = {
			name = 'position',
			opts = {
				format = 'Ln {line}:{col}',
				padding = { line = 3, col = 2 }
			}
		}
	}
	local mode = {
		provider = 'vi_mode',
		hl = function()
			return {
				name = require('feline.providers.vi_mode').get_mode_highlight_name(),
				fg = require('feline.providers.vi_mode').get_mode_color(),
				style = 'bold'
			}
		end,
		right_sep = ' ',
		-- Uncomment the next line to disable icons for this component and use the mode name instead
		-- icon = ''
	}

  local components = {
    active = {{fileinfo}, {}, {position, mode}},
    inactive = {{fileinfo}, {}}
  }
	local options = {
		components = components
	}

	feline.setup(options)
end

return { setup = setup }
