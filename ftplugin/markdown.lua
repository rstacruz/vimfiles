local function setup_zk_mappings()
	-- Open the link under the caret.
	-- map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

	-- -- Alternative for backlinks using pure LSP and showing the source context.
	-- --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

	local mappings = {
		n = {
			["K"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Preview link under cursor" },
			["<cr>"] = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Open linked file under cursor" },
			["gf"] = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Open linked file under cursor" },
			["<leader>zn"] = {
				"<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
				" Create new page…",
			},
			["<leader>zr"] = { "<Cmd>ZkBacklinks<CR>", " Show backlinks (references)" },
			["<leader>zl"] = { "<Cmd>ZkLinks<CR>", " Show outgoing links" },
		},
		v = {
			["<leader>zx"] = {
				-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
				":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
				" Extract selection to new file…",
			},
			["<leader>zl"] = {
				-- Create a new note in the same directory as the current buffer, using the current selection for title.
				":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
				" Link to new file…",
			},
		},
	}

	for key, value in pairs(mappings.n) do
		vim.api.nvim_buf_set_keymap(0, "n", key, value[1], { noremap = true, silent = false, desc = value[2] })
	end
	for key, value in pairs(mappings.n) do
		vim.api.nvim_buf_set_keymap(0, "v", key, value[1], { noremap = true, silent = false, desc = value[2] })
	end
end

-- Add the key mappings only for Markdown files in a zk notebook.
if BaseConfig.features.zk then
	if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
		setup_zk_mappings()
	end
end
