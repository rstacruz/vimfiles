-- Works like packer.startup(packages), but also downloads
-- and installs packer. Returns "false" when processing should stop.
local function bootstrap_packer(packages)
	-- On subsequent runs, skip the bootstrapping routine
	if vim.g.packer_bootstrapped then
		require("packer").startup(packages)
		return true
	end

	local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.filereadable(packer_path .. "/lua/packer.lua") == 0 then
		print("Installing packer…")
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
		vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
		vim.cmd("packadd packer.nvim")
		require("packer").startup(packages)
		require("packer").sync()
		return false
	end

	require("packer").startup(packages)
	require("packer").install()

	vim.g.packer_bootstrapped = true
	return true
end

return { bootstrap_packer = bootstrap_packer }
