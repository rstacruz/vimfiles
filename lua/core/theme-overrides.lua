local function apply()
	local cmd = vim.cmd

	vim.api.nvim_set_hl(0, "HopNextKey", { link = "Search" })
	vim.api.nvim_set_hl(0, "HopNextKey1", { link = "HopNextKey" })
	vim.api.nvim_set_hl(0, "HopNextKey2", { link = "HopNextKey" })

	-- Custom styles
	vim.api.nvim_set_hl(0, "XxLine", { link = "LineNr" }) -- borders and lines. also: Vertsplit

	-- Telescope
	vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "Search" })

	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "DevIconsTsx" })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "IncSearch" })
	vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "NonText" })

	-- Indent blankline
	vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { link = "CursorLine" }) -- The line that started the context
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { link = "XxLine" })
	vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "XxLine" })

	vim.api.nvim_set_hl(0, "CmpBorder", { link = "XxLine" }) -- Border for completions
	vim.api.nvim_set_hl(0, "BufferLineFill", { link = "TabLineFill" }) -- looks better in github_light

	vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { link = "Comment" }) -- Make some files less visible
	vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { link = "NonText" }) -- Make some files less visible
	vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { link = "Comment" }) -- make the heading less prominent
	vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "EndOfBuffer" }) -- better visual boundary from tree sidebar to the buffer

	local col = vim.g.colors_name
	local bg = vim.opt.background:get()

	-- different themes have different groups that look nice with borders
	if col == "terafox" or col == "nightfox" or col == "carbonfox" then
		vim.api.nvim_set_hl(0, "XxLine", { link = "Conceal" })
	end
	if col == "github_dimmed" then
		vim.api.nvim_set_hl(0, "HopNextKey", { link = "IncSearch" }) -- "Search" is too muted
	end

	if col == "nibble" then
		cmd([[hi! Comment guifg=#8080cc guibg=none gui=italic]])
		cmd([[hi! CursorLine gui=none guibg=#2020aa]]) -- Default was underline only
		cmd([[hi! LineNr guifg=#5555bb gui=italic]])
	end

	if ({ seoulbones = 1, rosebones = 1, zenbones = 1, dayfox = 1 })[col] and bg == "light" then
		cmd([[hi! Normal guibg=#ffffff]])
		cmd([[hi! NormalNC guibg=#fafafc]])
	end
end

local function setup()
	local augroup = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })
	vim.api.nvim_create_autocmd("Colorscheme", {
		pattern = "*",
		group = augroup,
		callback = apply,
	})
end

return { apply = apply, setup = setup }
