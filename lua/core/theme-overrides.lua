local function apply()
	local cmd = vim.cmd

	-- cmd([[hi! HopNextKey guibg=#ffddaa guifg=#000000]])
	-- cmd([[hi! HopNextKey1 guibg=#ffddaa guifg=#000000]])
	-- cmd([[hi! HopNextKey2 guibg=#ffddaa guifg=#000000]])
	cmd([[hi! link HopNextKey Search]])
	cmd([[hi! link HopNextKey1 Search]])
	cmd([[hi! link HopNextKey2 Search]])

	-- Custom styles
	cmd([[hi! link XxLine LineNr]]) -- borders and lines. also: Vertsplit

	cmd([[hi! link TelescopeNormal Pmenu]])
	cmd([[hi! link TelescopeBorder Pmenu]])
	cmd([[hi! link TelescopePreviewBorder Pmenu]])
	cmd([[hi! link TelescopeResultsBorder Pmenu]])
	cmd([[hi! link TelescopeTitle Search]])

	cmd([[hi! link TelescopePromptNormal CursorLine]])
	cmd([[hi! link TelescopePromptPrefix DevIconsTsx]])
	cmd([[hi! link TelescopePromptBorder CursorLine]])
	cmd([[hi! link TelescopePromptTitle IncSearch]])
	cmd([[hi! link TelescopePromptCounter NonText]])

	cmd([[hi! link IndentBlanklineContextStart CursorLine]]) -- the indent line that started the context
	cmd([[hi! link IndentBlanklineChar XxLine]])
	cmd([[hi! link IndentBlanklineContextChar XxLine]])

	cmd([[hi! link CmpBorder XxLine]]) -- Custom border for cmp completions

	cmd([[hi! link NvimTreeSpecialFile Comment]]) -- Make some files less visible
	cmd([[hi! link NvimTreeIndentMarker NonText]]) -- Make some files less visible
	cmd([[hi! link NvimTreeRootFolder Comment]]) -- make the heading less prominent
	cmd([[hi! link NvimTreeWinSeparator EndOfBuffer]]) -- better visual boundary from tree sidebar to the buffer

	local col = vim.g.colors_name
	local bg = vim.opt.background:get()

	-- different themes have different groups that look nice with borders
	if col == "terafox" or col == "nightfox" or col == "carbonfox" then
		cmd([[hi! link XxLine Conceal]])
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

function setup()
  local augroup = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })
  vim.api.nvim_create_autocmd("Colorscheme", {
    pattern = "*",
    group = augroup,
    callback = function()
      apply()
    end,
  })
end

return { apply = apply, setup = setup }
