local M = { -- Status line
  "feline-nvim/feline.nvim",
  lazy = false,
  disable = not BaseConfig.features.status_line,
}

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
	require("core.utils").on_colorscheme_change({ prefix = "Feline", callback = callback })
end

local function indent()
	return {
		provider = function()
			if vim.bo.expandtab == false then
				return ""
			else
				local val = vim.bo.softtabstop
				local sval = {
					[1] = "¹",
					[2] = "²",
					[4] = "⁴",
					[8] = "⁸",
				}
				return string.format("%s", sval[val] or val)
			end
		end,
		hl = { fg = "mute2" },
	}
end

local function rslash()
	return {
		provider = "    ",
		hl = { fg = "mute2" },
	}
end

local function navic()
	return {
		provider = function()
			if not vim.g.navic_available then
				return nil
			end
			local has_navic, nvim_navic = pcall(require, "nvim-navic")
			if not has_navic then
				return nil
			end

			local str = nvim_navic.get_location()
			return str == "" and "" or string.format(" %s", str)
		end,
		enabled = function()
			if not vim.g.navic_available then
				return nil
			end
			local has_navic, nvim_navic = pcall(require, "nvim-navic")
			return has_navic and nvim_navic and nvim_navic.is_available()
		end,
	}
end

local function invisible()
	return { provider = "", hl = { bg = "normal" } }
end

local function mode()
	return {
		provider = "vi_mode",
		hl = function()
			return {
				name = require("feline.providers.vi_mode").get_mode_highlight_name(),
				fg = require("feline.providers.vi_mode").get_mode_color(),
				bg = "bg",
			}
		end,
		icon = {
			str = " ●",
			always_visible = true,
		},
	}
end

local function setup_theme()
	local has, feline = pcall(require, "feline")
	if not has then
		return
	end

	local bg = extract_color({ "Pmenu", "StatusLine" }, "bg")
	local comment = extract_color({ "Comment" }, "fg")
	local separators = extract_color({ "VertSplit" }, "fg")
	local special = extract_color({ "Special" }, "fg")

	feline.use_theme({
		mute = extract_color({ "Comment" }, "fg"),
		mute2 = separators,
		bg = bg,
		fg = comment,
		mainfg = special,
		green = separators, -- normal vim mode
		red = special,
		skyblue = extract_color({ "DiagnosticError" }, "fg"), -- visual
	})
end

function M.config()
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
		short_provider = {
			name = "file_info",
			opts = {
				type = "short",
				file_readonly_icon = " ",
			},
		},
		hl = { fg = "mainfg" },
	}

	local shortfileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "short",
				file_readonly_icon = "",
			},
		},
		hl = { fg = "mute" },
	}

	local position = {
		provider = {
			name = "position",
			opts = {
				format = "{line}:{col}",
				padding = { line = 3, col = 2 },
			},
		},
		short_provider = "",
		icon = {
			str = "",
			hl = { fg = "mute2" },
		},
	}

	local capright = {
		hl = function()
			return { bg = "normal", fg = "bg" }
		end,
		icon = { str = " ", always_visible = true },
	}

	local capleft = {
		hl = function()
			return { bg = "normal", fg = "bg" }
		end,
		icon = { str = " ", always_visible = true },
	}

	local branch = {
		provider = "git_branch",
		short_provider = "",
		icon = { str = " ", hl = { fg = "mute2" } },
	}

	local rsep = { provider = "  " }
	local sep = { provider = " " }

	local components = {
		active = {
			{ capleft, sep, fileinfo, sep, navic() },
			{},
			{ branch, rslash(), indent(), sep, position, mode(), capright },
		}, -- left
		-- active = { { capleft, rsep, position }, { branch, rsep, fileinfo, rsep, capright } }, -- right
		inactive = { { capleft, sep }, { capright } },
	}

	local options = {
		components = components,
		conditional_components = {
			{
				condition = function()
					return vim.o.filetype == "help"
				end,
				active = { { capleft, sep, shortfileinfo }, {}, { capright } },
				inactive = { { invisible() }, {} },
			},
			{
				condition = function()
					return vim.o.filetype == "alpha"
				end,
				active = { { invisible() }, {} },
				inactive = { { invisible() }, {} },
			},
		},
		force_inactive = {
			filetypes = {
				"^NvimTree$",
				"^packer$",
				"^startify$",
				"^fugitive$",
				"^fugitiveblame$",
				"^qf$",
				"^TelescopePrompt$",
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

return M
