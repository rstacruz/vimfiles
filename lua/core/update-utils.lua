local function update()
	local config_path = vim.fn.stdpath("config")
	vim.cmd("lcd " .. config_path)
	local out = vim.fn.system({ "git", "pull", "--rebase", "--autostash" })
	vim.notify(out)
end

return { update = update }
