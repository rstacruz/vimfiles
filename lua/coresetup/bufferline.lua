-- Automatically re-apply bufferline when changing colorschemes.
local function on_colorscheme_change(callback)
	require("core.utils").on_colorscheme_change({ prefix = "Bufferline", callback = callback })
end

local function apply_options()
	local has, bufferline = pcall(require, "bufferline")
	if not has then
		return
	end

	local has_groups, groups = pcall(require, "bufferline.groups")

	local options = {
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
			separator_style = "thick", -- slant | thick | thin
			diagnostics = "nvim_lsp",
			tab_size = 24, -- Larger tabs (default: 18)
			show_close_icon = false, -- Close on the top-right (default false)
			sort_by = "insert_after_current", -- Works like the browser I guess

			-- Don't show the bufferline when there's only one file open. This makes startup feel faster,
			-- because it often takes a few moments before the bufferline appears on startup.
			always_show_bufferline = false,

			-- diagnostics_indicator = function(count, level)
			--	 local icon = level:match("error") and "" or ""
			--	 return " " .. icon .. count
			-- end,
			groups = {
				options = {
					-- When you re-enter a hidden group this options re-opens that group
					-- so the buffer is visible
					toggle_hidden_on_enter = true,
				},
				items = {
					has_groups and groups.builtin.ungrouped or nil,
					{
						name = "Docs",
						matcher = function(buf)
							return buf.filename:match("%.md") or buf.filename:match("%.txt")
						end,
					},
				},
			},
		},
	}

	bufferline.setup(options)
end

local function setup()
	apply_options()

	on_colorscheme_change(function()
		-- use vim.schedule to defer it. Colorscheme will run on startup
		vim.schedule(function()
			apply_options()
		end)
	end)
end

return { setup = setup }
