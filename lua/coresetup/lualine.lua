-- For these filetypes, hide some elements
local excluded_filetypes = {
	"toggleterm",
	"NvimTree",
	"DiffviewFiles",
	"neo-tree",
	"spectre_panel",
	"TelescopePrompt",
	"alpha",
	"NeogitStatus",
}

local function is_file()
	return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype or nil)
end

local function filename()
	return {
		"filename",
		icon = "",
		cond = is_file,
		symbols = { modified = " ●", readonly = " " },
	}
end

local function mode()
	return {
		"mode",
		fmt = function(str)
			return str:sub(1, 1)
		end,
		cond = is_file,
	}
end

local function terminal()
	return {
		function()
			return " " .. (vim.b.toggle_number or "0")
		end,
		cond = function()
			return vim.bo.filetype == "toggleterm"
		end,
	}
end

local function filetype()
	return {
		"filetype",
		cond = function()
			return is_file() and vim.o.columns > 100
		end,
		color = "lualine_c_inactive",
	}
end

local function branch()
	return {
		"branch",
		cond = function()
			return is_file() and vim.o.columns > 100
		end,
		color = "lualine_c_inactive",
	}
end

local function diagnostics()
	return {
		"diagnostics",
		source = { "nvim" },
		sections = { "error" },
	}
end

local function location()
	return { "location", icon = "", left_padding = 2, cond = is_file }
	-- 
end

local function navic()
	return {
		function()
			return require("nvim-navic").get_location()
		end,
		cond = function()
			if not vim.g.navic_available then
				return
			end
			local has_navic, nvim_navic = pcall(require, "nvim-navic")
			return has_navic and nvim_navic.is_available()
		end,
		color = "lualine_c_inactive",
	}
end

-- Returns a "bare minimal" theme.
local function get_simple_options()
	return {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {},
			lualine_b = { filename() },
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { mode() },
		},
	}
end

local function get_full_options()
	local options = {
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { filename(), terminal() },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		sections = {
			lualine_a = {},
			lualine_b = { filename(), diagnostics() },
			lualine_c = { navic() },
			lualine_x = { branch(), filetype(), location() },
			lualine_y = { terminal() },
			lualine_z = {},
		},
	}

	return vim.tbl_deep_extend("force", get_simple_options(), options)
end

local function setup()
	local has, lualine = pcall(require, "lualine")
	if not has then
		return
	end

	if BaseConfig.features.lazy_load_statusline then
		lualine.setup(get_full_options())
	else
		lualine.setup(get_simple_options())

		vim.schedule(function()
			lualine.setup(get_full_options())
		end)
	end

	vim.opt.laststatus = vim.fn.has("nvim-0.7") and 3 or 2
end

return { setup = setup }
