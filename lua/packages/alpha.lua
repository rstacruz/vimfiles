-- alpha: dashboard screen
local M = {
	"goolord/alpha-nvim",
	disable = not BaseConfig.features.welcome_screen,
	cmd = { "Alpha" },
	module = "alpha",
	event = { "VimEnter" },
}

local config = {
	-- Banner to show in the welcome screen
	banner = { "╲    ╱", " ╲  ╱ ", "  ╲╱ ", "" },
}

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

local function to_buttons(buttons)
	local result = {}
	for _, item in ipairs(buttons) do
		if type(item) == "table" then
			table.insert(result, button(item[1], item[2], item[3]))
		end
	end
	return result
end

local function get_config()
	local features = BaseConfig.features

	local buttons = {
		top = {
			{ "o", "  Open file…", "<cmd>lua require('core.actions').open_file_picker()<cr>" },
			{ "r", "  Recent files…", "<cmd>Telescope oldfiles only_cwd=true<cr>" },
			{ "-", "  Browse files", "<cmd>e .<cr>" },
			{ ".", "  Terminal", "<cmd>lua require('core.actions').open_terminal()<cr>" },
		},
		bottom = {
			{ "e", "  New file", "<cmd>ene<cr>" },
			{
				"z",
				"  Switch to dir…",
				"<cmd>lua require('telescope').extensions.z.list({})<cr>",
			},
			{ "q", "  Quit", "<cmd>qa<cr>" },
		},
	}

	local spacing = vim.o.lines > 25 and 1 or 0

	-- buttons
	local sections = {
		banner = {
			type = "text",
			val = config.banner,
			opts = { position = "center", hl = "VertSplit", redraw = false },
		},
		buttons_top = {
			type = "group",
			val = to_buttons(buttons.top),
			opts = { spacing = spacing, hl = "Normal" },
		},

		buttons_bottom = {
			type = "group",
			val = to_buttons(buttons.bottom),
			opts = { spacing = spacing, hl = "Normal" },
		},
		hr = {
			type = "text",
			val = "┄─┄",
			opts = { position = "center", hl = "VertSplit", redraw = true },
		},
	}

	local plugin_config = {
		layout = {
			{ type = "padding", val = 2 },
			sections.banner,
			{ type = "padding", val = 1 },
			sections.buttons_top,
			sections.hr,
			{ type = "padding", val = 1 },
			sections.buttons_bottom,
			{ type = "padding", val = 1 },
		},
		opts = {
			margin = 5,
		},
	}

	return plugin_config
end

function M.config()
	local has, alpha = pcall(require, "alpha")
	if not has then
		return
	end

	local config = get_config()
	alpha.setup(config)
end

return M
