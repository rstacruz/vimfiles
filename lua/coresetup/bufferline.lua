-- Automatically re-apply bufferline when changing colorschemes.
local function setup_colorscheme_hook(callback)
	local group = vim.api.nvim_create_augroup("BufferlineColorschemeHook", { clear = true })

	vim.api.nvim_create_autocmd("Colorscheme", {
		pattern = "*",
		group = group,
		callback = callback
	})
end

local function apply_options()
	local has, bufferline = pcall(require, "bufferline")
	if not has then
		return
	end

	local has_groups, groups = pcall(require, "bufferline.groups")

	local options = {
		options = {
			offsets = {
				{
					filetype = "NvimTree",
					text = function()
						return "" -- vim.fn.getcwd()
					end,
					highlight = "NvimTreeNormal",
					text_align = "left",
				},
			},
			separator_style = "thick", -- slant | thick | thin
			diagnostics = "nvim_lsp",

			-- Works like the browser I guess
			sort_by = "insert_after_current",

			-- diagnostics_indicator = function(count, level)
			--	 local icon = level:match("error") and "" or ""
			--	 return " " .. icon .. count
			-- end,
			groups = has_groups
					and {
						options = {
							toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
						},
						items = {
							groups.builtin.ungrouped,
							{
								name = "Docs",
								matcher = function(buf)
									return buf.filename:match("%.md") or buf.filename:match("%.txt")
								end,
							},
						},
					},
		},
	}

	bufferline.setup(options)
end

local function setup()
	apply_options()

	setup_colorscheme_hook(function()
		vim.schedule(function()
			apply_options()
		end)
	end)
end

return { setup = setup }
