later(function()
	local statusline = require("mini.statusline")

	local function active()
		local mode, mode_hl = statusline.section_mode({ trunc_width = 2 })
		-- local git = statusline.section_git({ trunc_width = 40 })
		-- local diff = statusline.section_diff({ trunc_width = 75 })
		local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
		local lsp = statusline.section_lsp({ trunc_width = 75 })
		local filename = statusline.section_filename({ trunc_width = 12 })
		-- local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
		-- local location = statusline.section_location({ trunc_width = 75 })
		local search = statusline.section_searchcount({ trunc_width = 75 })

		return statusline.combine_groups({
			{ hl = mode_hl, strings = { mode } },
			{ hl = "MiniStatuslineDevinfo", strings = { diagnostics, lsp } },
			"%<", -- Mark general truncate point
			{ hl = "MiniStatuslineFilename", strings = { filename } },
			"%=", -- End left alignment
			{ hl = "MiniStatuslineFileinfo", strings = { search } },
			{ hl = "MiniStatuslineFileinfo", strings = { "%2l:%-2v" } },
		})
	end
	statusline.setup({ content = { active = active } })
end)

later(function()
	require("mini.git").setup()
	require("mini.icons").setup()
	require("mini.diff").setup()
end)
