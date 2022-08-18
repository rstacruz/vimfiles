local function setup()
	local has, fidget = pcall(require, "fidget")
	if not has then
		return
	end

	local options = {
	}

	fidget.setup(options)
end

return { setup = setup }
