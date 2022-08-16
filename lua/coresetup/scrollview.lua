local function setup()
	local has, scrollview = pcall(require, "scrollview")
	if not has then
		return
	end

	local options = {
		-- Make it sit flush to the window edge. (default: 2)
		column = 1,
	}

	scrollview.setup(options)
end

return { setup = setup }
