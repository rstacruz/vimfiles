local function setup()
	local has, gitsigns = pcall(require, "gitsigns")
	if not has then
		return
	end

	gitsigns.setup({
		signs = {
			changedelete = { text = "▌" }, -- Originally "~"
			change = { text = "▌" },
			add = { text = "▌" },
		},
	})
end

return { setup = setup }
