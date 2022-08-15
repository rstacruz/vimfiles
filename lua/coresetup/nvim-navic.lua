local function setup()
	local has, navic = pcall(require, "nvim-navic")
	if not has then
		return
	end

	local options = {
		separator = " ╱ "
	}

	navic.setup(options)
end

return { setup = setup }
