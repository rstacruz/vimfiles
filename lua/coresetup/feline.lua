local function extract_color_from_group(color_group, what)
	local ok, color = pcall(function()
		return vim.api.nvim_get_hl_by_name(color_group, true)
	end)

	if not ok then
		return nil
	end

	if color.foreground ~= nil and what == "fg" then
		return string.format("#%06x", color.foreground)
	end

	if color.background ~= nil then
		return string.format("#%06x", color.background)
	end
end

-- extract_color({"Normal", "Comment"}, "fg") --> "#333444"
local function extract_color(color_groups, what)
	for _, color_group in ipairs(color_groups) do
		local result = extract_color_from_group(color_group, what)
		if result ~= nil then
			return result
		end
	end
end

local function on_colorscheme_change(callback)
	local group = vim.api.nvim_create_augroup("FelineColorscheme", { clear = true })
	vim.api.nvim_create_autocmd("Colorscheme", {
		pattern = "*",
		group = group,
		callback = callback,
	})
end

local function setup_theme()
	local has, feline = pcall(require, "feline")
	if not has then
		return
	end
	local bg = extract_color({ "Pmenu", "StatusLine" }, "bg")

	feline.use_theme({
		mute = extract_color({ "Comment" }, "fg"),
		mute2 = extract_color({ "VertSplit" }, "fg"),
		bg = bg,
		fg = extract_color({ "Comment" }, "fg"),
		mainfg = extract_color({ "Normal" }, "fg"),
		green = bg, -- normal vim mode
		red = extract_color({ "DiagnosticHint" }, "fg"), -- insert
		skyblue = extract_color({ "DiagnosticError" }, "fg"), -- visual
	})
end

local function setup()
	if vim.g.hot_reload then
		require("plenary.reload").reload_module("feline")
	end

	local has, feline = pcall(require, "feline")
	if not has then
		return
	end

	if vim.g.hot_reload then
		feline.reset_highlights()
	end

	local fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "relative",
				file_readonly_icon = " ",
			},
		},
		hl = { fg = "mainfg" },
	}

	local position = {
		provider = {
			name = "position",
			opts = {
				format = "{line}:{col}",
				padding = { line = 3, col = 2 },
			},
		},
		icon = {
			str = "",
			hl = { fg = "mute2" },
		},
	}
	local modeleft = {
		provider = "vi_mode",
		hl = function()
			return {
				name = require("feline.providers.vi_mode").get_mode_highlight_name(),
				fg = require("feline.providers.vi_mode").get_mode_color(),
				bg = "normal",
			}
		end,
		icon = {
			str = " ▐",
			always_visible = true,
		},
		-- Uncomment the next line to disable icons for this component and use the mode name instead
		-- icon = ''
	}
	local capright = {
		hl = function()
			return {
				bg = "normal",
			}
		end,
		icon = {
			str = "  ",
			always_visible = true,
		},
	}

	local branch = {
		provider = "git_branch",
		icon = { str = " ", hl = { fg = "mute2" } },
	}

	local rsep = { provider = "  " }

	local components = {
		-- active = { { modeleft, pad, fileinfo }, {}, { branch, rsep, position, rsep } },
		active = { { modeleft, rsep, position, rsep, branch, rsep }, { fileinfo, rsep, capright } },
		inactive = { { modeleft, rsep }, { capright } },
	}

	local options = {
		components = components,
		conditional_components = {
			condition = function()
				return true
			end,
			active = { { position, fileinfo }, {} },
			inactive = { {}, {} },
		},
		force_inactive = {
			filetypes = {
				"^NvimTree$",
				"^packer$",
				"^startify$",
				"^fugitive$",
				"^fugitiveblame$",
				"^qf$",
				"^help$",
				"^alpha$",
			},
			buftypes = {
				"^terminal$",
			},
			bufnames = {},
		},
	}

	feline.setup(options)

	local group = vim.api.nvim_create_augroup("FelineColorscheme", { clear = true })
	vim.api.nvim_create_autocmd({ "Colorscheme" }, {
		pattern = "*",
		group = group,
		callback = setup_theme,
	})

	setup_theme()

	on_colorscheme_change(function()
		setup_theme()
	end)
end

return { setup = setup }
