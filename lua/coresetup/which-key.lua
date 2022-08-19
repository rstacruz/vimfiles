local function setup()
	local has, which_key = pcall(require, "which-key")
	if not has then
		return
	end

	local options = {
		window = {
			border = "none", -- none single double shadow
			position = "bottom",
			margin = { 0, 10, 2, 10 }, -- trbl
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
		plugins = {
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		icons = {
			breadcrumb = "›", -- in the command line area
			separator = "┄", -- between a key and it's label
			group = "", -- 
		},
	}
	which_key.setup(options)
end

return { setup = setup }
