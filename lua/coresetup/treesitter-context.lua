local function setup()
	local has, treesitter_context = pcall(require, "treesitter_context")
	if not has then
		return
	end

	local options = {
		enable = true,

		-- How many lines the window should span, 0 for no limit. (default: 0)
		max_lines = 0,
	}

	treesitter_context.setup(options)
end

return { setup = setup }
