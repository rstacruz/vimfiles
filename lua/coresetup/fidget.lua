local function setup()
	local has, fidget = pcall(require, "fidget")
	if not has then
		return
	end

	local options = {
		text = {
			spinner = "dots", -- default: "pipe"
		},
		fmt = {
			fidget = function(name, spinner)
				return string.format("%s %s ", name, spinner)
			end,
			task = function(name, msg, percentage)
				local percentage_str = percentage and string.format(" (%s%%)", percentage)
				if msg == "Completed" then
					return string.format("Done: %s ✓ ", name)
				end
				return string.format("%s %s %s ", msg, percentage_str, name)
			end,
		},
	}

	fidget.setup(options)
end

return { setup = setup }
