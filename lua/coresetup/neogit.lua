local function setup()
	local has, neogit = pcall(require, "neogit")
	if not has then
		return
	end

	local options = {
		signs = {
			section = { " ", " " },
			item = { " ", " " },
		},
		integrations = {
			diffview = true, -- uses sindrets/diffview.nvim
		},
	}

	neogit.setup(options)
end

return { setup = setup }
