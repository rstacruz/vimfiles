local function setup()
	local has, pounce = pcall(require, "pounce")
	if not has then
		return
	end

	local options = {
		-- Colemak DH
		accept_keys = "NEIHOTSRDACXPLFUWY",
	}

	pounce.setup(options)
end

return { setup = setup }
