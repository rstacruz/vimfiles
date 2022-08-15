local function setup()
	local has, which_key = pcall(require, "which-key")
	if not has then
		return
	end

	local options = {
		window = {
			border = "none", -- none single double shadow
			position = "bottom",
			margin = { 0, 0, 1, 0 }, -- trbl
		},
		layout = {
			spacing = 6,
			height = { min = 25, max = 25 },
		},
		key_labels = {
			["<leader>"] = "",
			["<space>"] = "␣",
		},
		show_help = false,
		icons = {
			breadcrumb = "›", -- in the command line area
			separator = "┄", -- between a key and it's label
			group = " ",
		},
	}
	which_key.setup(options)
end

return { setup = setup }
