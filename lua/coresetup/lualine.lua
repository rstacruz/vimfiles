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
	return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
end

local function is_blank()
	-- Prevent "[No Name]" from appearing
	return vim.bo.modified == false and vim.fn.expand("%:t") == ""
end

local function cwd()
	return {
		function()
			local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			return " " .. pwd
		end,
		-- color = "lualine_c_inactive",
	}
end

local function welcome()
	return {
		function()
			return "Press <space> to get started"
		end,
		color = "lualine_c_inactive",
		cond = is_blank,
	}
end

local function filename()
	return {
		"filename",
		icon = "",
		cond = function()
			return is_file() and not is_blank()
		end,
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
		-- color = "lualine_c_inactive",
	}
end

local function branch()
	return {
		"branch",
		icon = "",
		cond = function()
			return is_file() and vim.o.columns > 100
		end,
		-- color = "lualine_c_inactive",
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
	return { "location", icon = "", cond = is_file }
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
			lualine_c = { welcome(), navic() },
			lualine_x = { filetype(), cwd(), branch() },
			lualine_y = { terminal(), location() },
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
