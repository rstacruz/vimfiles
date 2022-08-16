-- Focus on the next pane, resizing it as needed.
local function next_pane(offset)
	local settings = BaseConfig.pane_navigation

	vim.cmd(offset == -1 and "wincmd w" or "wincmd W")

	if not vim.tbl_contains(settings.excluded_filetypes, vim.bo.filetype) and settings.min_width ~= -1 then
		local before = vim.o.winwidth
		vim.o.winwidth = settings.min_width
		vim.o.winwidth = before
	end
end

local function prev_pane()
	return next_pane(-1)
end

return {
	next_pane = next_pane,
	prev_pane = prev_pane,
}
