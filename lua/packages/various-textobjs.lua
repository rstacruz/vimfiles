-- various-textobjs: text objects for indent levels and so on.
--
--     vai   - select all in [i]ndent level
--     civ   - change [v]alue (rhs of a variable assignment)
--     cik   - change [k]ey (lhs)
--     cin   - change [n]umber
--
local M = {
	"chrisgrieser/nvim-various-textobjs",
	event = "VeryLazy",
}

function M.config()
	require("various-textobjs").setup({
		useDefaultKeymaps = true,
	})

	-- "rest of paragraph" conflicts with Neovim's default `r` for replace
	vim.keymap.del({ "o", "x" }, "r")
end

return M
