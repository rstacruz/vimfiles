-- fidget: spinners for lsp messages
local M = {
	"j-hui/fidget.nvim",
	enable = BaseConfig.features.lsp,
	module = "fidget",
	event = "BufRead",
}

function M.config()
	local fidget = require("fidget")

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

return M
