local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_no_args = vim.fn.argc(-1) > 0 and later or now

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

-- ...
-- :DepsUpdate
--
-- todo:
-- * mini-files: arrow keys https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-files.md
-- * replace Trouble with mini.extra diagnostics
-- * mini.diff - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-diff.md
-- * blink cmp
-- * akinsho/bufferline
-- * `s` jumping
-- * leader-un toggle for numbers
-- * code actions
-- * recent
-- * show diagnostic info on K
-- * snacks.picker.keymaps()
-- * fold appearance
-- * ctrl-h ctrl-l
-- * bufferline
-- * markdown
-- * diffview
