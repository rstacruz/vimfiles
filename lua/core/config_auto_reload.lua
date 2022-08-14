-- Automatically compile when writing init.lua
local function setup()
	local group = vim.api.nvim_create_augroup("PackerReload", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = vim.env.MYVIMRC,
		group = group,
		callback = function(s)
      vim.schedule(function()
        reload()
        require("packer").compile()
        print("Config reloaded :)")
      end)
		end,
	})
end

return { setup = setup }
