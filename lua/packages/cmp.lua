-- cmp: Completions
local M = {
	"hrsh7th/nvim-cmp",
	disable = not BaseConfig.features.completions,
	event = "InsertEnter",
	dependencies = {
		"onsails/lspkind-nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
	},
}

local function get_borders(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

function M.config()
	-- Without this, hot-reload will make entries appear twice or more
	if vim.g.hot_reload then
		require("plenary.reload").reload_module("cmp")
	end

	local cmp = require("cmp")

	local has_lspkind, lspkind = pcall(require, "lspkind")
	local formatting = has_lspkind
			and {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
				}),
			}
		or {}

	local mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping.confirm(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	})

	local options = {
		window = {
			completion = {
				border = get_borders("CmpBorder"),
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				border = get_borders("CmpBorder"),
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
		},
		mapping = mapping,
		formatting = formatting,
		completion = {
			keyword_length = 2,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "emoji" },
		}),
	}

	cmp.setup(options)

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- BUG: hot-reloading will have path entries listed twice
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
