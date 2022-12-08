local function setup()
	local has, surround = pcall(require, "nvim-surround")
	if not has then
		return
	end

	local options = {}

	surround.setup(options)
end

return { setup = setup }
