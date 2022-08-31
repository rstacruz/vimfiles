local function setup()
	local has, zk = pcall(require, "zk")
	if not has then
		return
	end

	local options = {
		-- use Telescope rather than vim.ui.select
		picker = "telescope",
	}

	zk.setup(options)
end

return { setup = setup }
