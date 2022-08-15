local function setup()
	local has, autopairs = pcall(require, "nvim-autopairs")
	if not has then
		return
	end

	local options = {}

	autopairs.setup(options)
end

return { setup = setup }
