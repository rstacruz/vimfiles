local M = {}

-- Automatically run `chezmoi apply` after saving a chezmoi managed file
M.setup = function()
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
		group = vim.api.nvim_create_augroup("auto_chezmoi", { clear = true }),
		callback = function()
			vim.fn.jobstart({ "chezmoi", "apply" }, {
				detach = true,
				on_exit = function(_, code)
					if code == 0 then
						vim.schedule(function()
							vim.notify("chezmoi apply: success", vim.log.levels.INFO)
						end)
					else
						vim.schedule(function()
							vim.notify("chezmoi apply: failed", vim.log.levels.ERROR)
						end)
					end
				end,
			})
		end,
	})
end

return M
