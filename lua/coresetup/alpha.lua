-- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/darshboard.lua
local function button(shortcut, text, command)
	return {
		type = "button",
		val = text,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(shortcut .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "t", false)
		end,
		opts = {
			position = "center",
			shortcut = shortcut,
			cursor = 5,
			width = 30,
			align_shortcut = "right",
			hl_shortcut = "Keyword",
			keymap = { "n", shortcut, command, { noremap = true, silent = true, nowait = true } },
		},
	}
end

local function get_config()
	local has_explorer = BaseConfig.features.file_explorer

	-- buttons
	local section_buttons = {
		type = "group",
		val = {
			button("o", "  Open file…", "<cmd>lua require('core.actions').open_file_picker()<cr>"),
			button("r", "  Recent files…", "<cmd>Telescope oldfiles<cr>"),
			has_explorer and button("-", "  Browse files", "<cmd>e .<cr>"),
			button(".", "  Open terminal", "<cmd>lua require('core.actions').open_terminal()<cr>"),
		},
		opts = { spacing = 1, hl = "Normal" },
	}

	local section_buttons_2 = {
		type = "group",
		val = {
			button("e", "  New file", "<cmd>ene<cr>"),
			button("w", "  Switch project…", "<cmd>WorkspacesList<cr>"),
			button("q", "  Quit", "<cmd>qa<cr>"),
		},
		opts = { spacing = 1, hl = "Normal" },
	}

	local config = {
		layout = {
			{ type = "padding", val = 5 },
			{
				type = "text",
				val = BaseConfig.welcome_screen.banner,
				opts = { position = "center", hl = "Comment", redraw = true },
			},
			{ type = "padding", val = 1 },
			section_buttons,
			{ type = "padding", val = 1 },
			{
				type = "text",
				val = "┄─┄",
				opts = { position = "center", hl = "VertSplit", redraw = true },
			},
			{ type = "padding", val = 1 },
			section_buttons_2,
			{ type = "padding", val = 1 },
			-- { type = "group", val = section_mru.val, },
			-- { type = "padding", val = 1 },
		},
		opts = {
			margin = 5,
		},
	}

	return config
end

local function setup()
	local has, alpha = pcall(require, "alpha")
	if not has then
		return
	end

	local config = get_config()
	alpha.setup(config)
end

return { setup = setup }
