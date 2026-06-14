-- Graveyard: removed/deprecated plugin configs kept for reference.
-- This file is NOT sourced — nothing here runs.

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later
local now_if_no_args = vim.fn.argc(-1) > 0 and later or now

later(function() -- smear-cursor
	if not vim.g.neovide then
		add({ source = "sphamba/smear-cursor.nvim" })
		require("smear_cursor").setup({})
	end
end)

-- interferes with mouse scroll
later(function() -- mini.animate
	local animate = require("mini.animate")
	local fast = animate.gen_timing.cubic({ duration = 60, unit = "total" })
	local xfast = animate.gen_timing.cubic({ duration = 20, unit = "total" })

	animate.setup({
		cursor = { enable = false },
		scroll = { timing = fast },
		resize = { timing = xfast },
	})
end)

-- measure startup time
local start = (vim.uv or vim.loop).hrtime()
now(function()
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = { "*" },
		callback = function()
			local now = (vim.uv or vim.loop).hrtime()
			local delta = now - start
			local loadtime = string.format("Loaded in %.2f ms", delta / 1e6)
			vim.g.lol = loadtime -- display later?
		end,
	})
end)

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = { "*" },
	callback = function()
		local now = (vim.uv or vim.loop).hrtime()
		local delta = now - start
		local loadtime = string.format("Loaded in %.2f ms", delta / 1e6)
		print(loadtime)
		vim.notify(loadtime)
		vim.g.lol = loadtime
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = { "*" },
	callback = function()
		local now = (vim.uv or vim.loop).hrtime()
		local delta = now - start
		local loadtime = string.format("Loaded in %.2f ms", delta / 1e6)
		print(loadtime)
		vim.notify(loadtime)
		vim.g.lol = loadtime
	end,
})
now_if_no_args(function() -- mini.starter
	local starter = require("mini.starter")

	local function get_banner()
		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		local logo = "" .. cwd .. "\n" .. string.rep("─", #cwd)
		return logo
	end

	local function get_footer()
		return " "
	end

	starter.setup({
		evaluate_single = true, -- trigger on 1 keypress instead of having to press enter
		footer = get_footer,
		header = get_banner,
		query_updaters = "eq0123456789",
		content_hooks = {
			starter.gen_hook.adding_bullet(), -- line on the left
			starter.gen_hook.indexing("all", { "Builtin actions" }), -- numbers
			starter.gen_hook.aligning("center", "center"),
		},
	})
end)

later(function() -- render-markdown
	add({ source = "MeanderingProgrammer/render-markdown.nvim" })
	require("render-markdown").setup({
		heading = {
			-- default:
			-- signs = { "󰫎 " },
			-- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			icons = { "━ " },
			signs = { "󰎤 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
			-- signs = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " }, -- nf-md-numeric_0_box_outline
			-- signs = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- nf-md-numeric_0_box
			-- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- nf-md-numeric_0_box
			-- signs = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "󰲩", "󰲫" },
			-- signs = { "∙", "∶", "∴", "∷", "󰲩", "󰲫" },
			-- signs = { "━ " },
			-- sign = false,
		},
		checkbox = {
			-- "󰄲" -- nf-md-checkbox_marked
			-- "󰄳" -- nf-md-checkbox_marked_circle
			-- "󰄰" -- nf-md-checkbox_blank_circle_outline
			-- "󰸞" -- nf-md-check-bold
			-- "󰏤" -- nf-md-pause
			-- "󰜺" -- nf-md-cancel
			-- "󰄬" -- nf-md-check
			-- Comment = grey
			-- RenderMarkdownTodo = cyan?
			-- DiagnosticOk = green
			-- DiagnosticError = red
			-- DiagnosticInfo = cyan
			-- DiagnosticWarn = yellow
			-- RenderMarkdownHint, _Question - yellow
			-- RenderMarkdownSuccess - green
			-- RenderMarkdownInfo - blue
			-- RenderMarkdownError - red
			custom = {
				prog1 = { raw = "[1]", rendered = "󰂎", highlight = "DiagnosticInfo" },
				prog2 = { raw = "[2]", rendered = "󱊡", highlight = "DiagnosticInfo" },
				prog4 = { raw = "[4]", rendered = "󱊢", highlight = "DiagnosticInfo" },
				prog8 = { raw = "[8]", rendered = "󱊣", highlight = "DiagnosticInfo" },
				delegated = { raw = "[d]", rendered = "👤", highlight = "Comment" }, -- in progress, nf-md-texture_box
			},
		},
	})
end)

-- Restore status line that was hidden earlier
---@param value number
local function defer_laststatus_update_on_insert(value)
	local group = vim.api.nvim_create_augroup("restore", { clear = true })
	vim.api.nvim_create_autocmd("InsertEnter", {
		group = group,
		callback = function()
			vim.opt.laststatus = value
			vim.api.nvim_del_augroup_by_id(group)
		end,
	})
end

later(function() -- ts-comments
	-- when using `gc` to toggle comments, make it use the correct comment
	-- eg, {/* ... */} in JSX
	add({ source = "folke/ts-comments.nvim" })
	require("ts-comments").setup({})
end)

require("blink.cmp").setup({
	keymap = { preset = "default", ["<cr>"] = { "accept", "fallback" } },
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "prefer_rust" },

	-- show signature help when typing (
	signature = { enabled = true },

	-- sources = {
	-- 	default = { "lsp", "path", "snippets", "buffer", "copilot" },
	-- 	providers = {
	-- 		copilot = {
	-- 			name = "copilot",
	-- 			module = "blink-cmp-copilot",
	-- 			score_offset = 100,
	-- 			async = true,
	-- 		},
	-- 	},
	-- },
})

-- * mini-files: arrow keys https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-files.md

later(function() -- marks
	add({ source = "chentoast/marks.nvim" })

	-- marks: highlights marks in the signcolumn, and shows a list of marks
	-- similar to harpoon
	require("marks").setup({})
end)

later(function() -- difft
	-- https://github.com/ahkohd/difft.nvim
	add({ source = "ahkohd/difft.nvim" })
	require("difft").setup({
		command = "GIT_EXTERNAL_DIFF='difft --color=always' git diff",
		layout = "float",
	})
end)
