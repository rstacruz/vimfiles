local M = {
	-- navic: status bar display of context
	"SmiteshP/nvim-navic",
	enabled = BaseConfig.features.lsp,
	event = "VeryLazy",
}

function M.config()
	vim.g.navic_available = true
	vim.g.navic_silence = true

	local navic = require("nvim-navic")
	navic.setup({
		separator = "  ",

		-- Provide different highlights. But it's not very reliable
		-- highlight = true,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("NavicLspAttach", { clear = true }),
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			navic.attach(client, buffer)
		end,
	})
end

return M
