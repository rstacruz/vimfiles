local M = {}

M.get_obsidian_workspaces = function()
	local workspaces = {}
	local home = os.getenv("HOME")
	local vaults_dir = home .. "/Documents/Vaults/*"
	local items = vim.fn.glob(vaults_dir, false, true)

	for _, filepath in ipairs(items) do
		if vim.fn.isdirectory(filepath) == 1 then
			local name = vim.fn.fnamemodify(filepath, ":t")
			local item = { path = filepath, name = name }
			table.insert(workspaces, item)
		end
	end

	return workspaces
end

M.bind_keys = function(buf)
  -- stylua: ignore start
	vim.keymap.set("n", "<leader>mp", "<cmd>Obsidian paste_img<CR>", { buffer = buf, desc = "Obsidian: Paste image" })
	vim.keymap.set("v", "<leader>mx", "<cmd>Obsidian extract_note<CR>", { buffer = buf, desc = "Obsidian: Extract to..." })
	vim.keymap.set("n", "<leader>mc", "<cmd>Obsidian toggle_checkbox<CR>", { buffer = buf, desc = "Obsidian: Toggle checkbox" })
	vim.keymap.set("n", "<leader>ms", "<cmd>Obsidian follow_link vsplit<CR>", { buffer = buf, desc = "Obsidian: Follow link in vsplit" })
	vim.keymap.set("n", "<leader>mr", "<cmd>Obsidian backlinks<CR>", { buffer = buf, desc = "Obsidian: Show backlinks" })
	vim.keymap.set("n", "<leader>mR", "<cmd>Obsidian rename<CR>", { buffer = buf, desc = "Obsidian: Rename..." })
	vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<CR>", { buffer = buf, desc = "Obsidian: Follow link" })
	-- vim.keymap.set("n", "gr", "<cmd>Obsidian backlinks<CR>", { buffer = buf, desc = "Obsidian: Show backlinks" })
	-- stylua: ignore end
end

M.get_obsidian_options = function()
	local opts = {
		legacy_commands = false,
		workspaces = M.get_obsidian_workspaces(),
		notes_subdir = "Pages",
		new_notes_location = "notes_subdir", -- options: current_dir (default), notes_subdir
		ui = { enable = false }, -- use render-markdown.nvim instead
		templates = { folder = "Templates" },
		completion = { blink = true },
		attachments = { img_folder = "Media" }, -- default: "assets/imgs"
		preferred_link_style = "wiki",
		picker = { name = "snacks.pick" },

		note_frontmatter_func = M.note_frontmatter_func,

		note_id_func = M.note_id_func,

		-- when using `gf` on a URL by mistake
		follow_url_func = vim.ui.open,
		follow_img_func = vim.ui.open,

		backlinks = {
			-- When 'true', using `:ObsidianBacklinks` will look for backlinks to the header
			-- under the cursor. Defaults to true.
			parse_headers = false,
		},
	}

	return opts
end

M.note_id_func = function(raw_title)
	-- Default behaviour: return something like "124351678905-XYZX"
	if raw_title then
		local title = raw_title:gsub(":", ";")
		return title
	end

	return "Untitled-" .. tostring(os.time())
end

M.note_frontmatter_func = function(note)
	local out = {}

	if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
		for k, v in pairs(note.metadata) do
			out[k] = v
		end
	end

	-- Add createdAt: in the frontmatter
	if out.createdAt == nil then
		-- "2405 Page" -> 2024-05-01
		local datestamp = os.date("!%Y%m")
		---@cast datestamp string
		if string.match(note.id, "^%d%d%d%d ") and string.sub(note.id, 1, 4) ~= string.sub(datestamp, 3, 9) then
			local year = "20" .. string.sub(note.id, 1, 2)
			local month = string.sub(note.id, 3, 4)
			local ymd = "" .. year .. "-" .. month .. "-01T00:00:00Z"
			out.createdAt = ymd
		else
			out.createdAt = os.date("!%Y-%m-%dT%TZ")
		end
	end

	-- -- Only save aliases if they're not the same as [self]
	-- if note.aliases and next(note.aliases) ~= nil and (#note.aliases ~= 1 or note.aliases[1] ~= note.id) then
	--   out.aliases = note.aliases
	-- end

	-- if note.tags and next(note.tags) ~= nil then
	--   out.tags = note.tags
	-- end

	return out
end

return M
