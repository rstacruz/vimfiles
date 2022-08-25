local config = {
	base = {
		HopNextKey = { link = "Search" },
		HopNextKey1 = { link = "HopNextKey" },
		HopNextKey2 = { link = "HopNextKey" },

		-- Custom styles
		XxLine = { link = "LineNr" }, -- borders and lines. also: Vertsplit

		-- Telescope
		TelescopeNormal = { link = "Pmenu" },
		TelescopeBorder = { link = "Pmenu" },
		TelescopePreviewBorder = { link = "Pmenu" },
		TelescopeResultsBorder = { link = "Pmenu" },
		TelescopeTitle = { link = "Search" },

		TelescopePromptNormal = { link = "CursorLine" },
		TelescopePromptPrefix = { link = "DevIconsTsx" },
		TelescopePromptBorder = { link = "CursorLine" },
		TelescopePromptTitle = { link = "IncSearch" },
		TelescopePromptCounter = { link = "NonText" },

		-- Indent blankline
		IndentBlanklineContextStart = { link = "CursorLine" }, -- The line that started the context
		IndentBlanklineChar = { link = "XxLine" },
		IndentBlanklineContextChar = { link = "XxLine" },

		-- https://github.com/folke/which-key.nvim
		WhichKeyFloat = { link = "Pmenu" }, -- Nicer background especaiily github_dark
		WhichKeyDesc = { link = "Pmenu" },
		WhichKeyGroup = { link = "Type" },

		NavicSeparator = { link = "XxLine" },

		CmpBorder = { link = "XxLine" }, -- Border for completions
		BufferLineFill = { link = "TabLineFill" }, -- looks better in github_light

		NvimTreeSpecialFile = { link = "Comment" }, -- Make some files less visible
		NvimTreeIndentMarker = { link = "NonText" }, -- Make some files less visible
		NvimTreeRootFolder = { link = "Comment" }, -- make the heading less prominent
		NvimTreeWinSeparator = { link = "EndOfBuffer" }, -- better visual boundary from tree sidebar to the buffer
	},
	nibble = {
		Comment = { fg = "#8080cc", bg = "none", italic = 1 },
		CursorLine = { italic = 0, bg = "#2020aa" }, -- Default was underline
		LineNr = { fg = "#5555bb", italic = 0 },
		-- Normal = { bg = "#333366" },
		-- NormalNC = { bg = "#333366" },
	},
}

local function apply_list(list)
	for key, value in pairs(list) do
		vim.api.nvim_set_hl(0, key, value)
	end
end

local function apply()
	local col = vim.g.colors_name

	apply_list(config.base)

	-- different themes have different groups that look nice with borders
	if vim.tbl_contains({ "terafox", "nightfox", "carbonfox" }, col) then
		vim.api.nvim_set_hl(0, "XxLine", { link = "Conceal" })
	end

	if vim.tbl_contains({ "github_dark", "github_dimmed" }, col) then
		vim.api.nvim_set_hl(0, "HopNextKey", { link = "IncSearch" }) -- "Search" is too muted
	end

	if col == "nibble" then
		apply_list(config.nibble)
	end

	-- if ({ seoulbones = 1, rosebones = 1, zenbones = 1, dayfox = 1 })[col] and bg == "light" then
	-- 	cmd([[hi! Normal guibg=#ffffff]])
	-- 	cmd([[hi! NormalNC guibg=#fafafc]])
	-- end
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
