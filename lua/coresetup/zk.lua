local function setup()
	local has, zk = pcall(require, "zk")
	if not has then
		return
	end

	local options = {}

	zk.setup(options)
end

return { setup = setup }
