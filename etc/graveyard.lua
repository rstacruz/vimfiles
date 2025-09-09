local now, later = MiniDeps.now, MiniDeps.later

later(function() -- render-markdown
	MiniDeps.add({ source = "MeanderingProgrammer/render-markdown.nvim" })
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
