local function setup()
	local has, navic = pcall(require, "nvim-navic")
	if not has then
		return
	end

	local options = {
		separator = " ╱ ",

		-- Provide different highlights. But it's not very reliable
		-- highlight = true,
	}

	navic.setup(options)
end

return { setup = setup }
