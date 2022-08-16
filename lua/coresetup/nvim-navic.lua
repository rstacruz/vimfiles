local function setup()
	local has, navic = pcall(require, "nvim-navic")
	if not has then
		return
	end

	local options = {
		separator = " ╱ ",
		highlight = true,
	}

	navic.setup(options)
end

return { setup = setup }
