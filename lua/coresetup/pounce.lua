local function setup()
	local has, pounce = pcall(require, "pounce")
	if not has then
		return
	end

	local options = {
		-- Colemak DH
		accept_keys = "NEIHOTSRDACXPLFUWY",
		-- accept_keys = "1234567890",

		-- Follows the "best" match. (default: "<enter>")
		accept_best_key = "<space>",
	}

	pounce.setup(options)
end

return { setup = setup }
