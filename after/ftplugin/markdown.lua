vim.opt_local.cursorline = false -- doesn't look good with headlines
vim.opt_local.spell = false -- I find spellcheck only useful when writing prose. toggle with leader-us
vim.opt_local.wrap = false -- inline links make wrapping very weird. toggle with leader-uw
vim.opt_local.relativenumber = false
vim.opt_local.number = false -- toggle with leader-ul

local function gh_preview()
	vim.cmd("write")
	local file = vim.fn.expand("%:p")
	vim.fn.jobstart({ "gh", "markdown-preview", file }, { detach = true })
end

vim.keymap.set("n", "<leader>mp", gh_preview, { buffer = true, desc = "Markdown: preview in browser…" })