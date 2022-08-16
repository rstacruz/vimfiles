local function setup()
	local has, neogit = pcall(require, "neogit")
	if not has then
		return
	end

	neogit.setup({
		signs = {
			section = { "▶ ", "▼ " },
			item = { " ▶", " ▼" },
		},
		integrations = {
			diffview = true, -- uses sindrets/diffview.nvim
		},
	})
end

return { setup = setup }
