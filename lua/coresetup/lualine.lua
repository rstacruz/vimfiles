local function is_file()
	local nonfile_types = {
		toggleterm = true,
		NvimTree = true,
		["neo-tree"] = true,
		spectre_panel = true,
		TelescopePrompt = true,
		alpha = true,
	}
	return not (nonfile_types[vim.bo.filetype] or false)
end

local function get_theme(opts)
	-- local has_gps, gps = pcall(require, "nvim-gps")

	local terminal = {
		function()
			return [[ ]] .. (vim.b.toggle_number or "0")
		end,
		cond = function()
			return vim.bo.filetype == "toggleterm"
		end,
	}

	local filename = {
		"filename",
		icon = "",
		cond = is_file,
		symbols = { modified = " ●", readonly = " " },
	}

	local mode = {
		"mode",
		fmt = function(str)
			return str:sub(1, 1)
		end,
		cond = is_file,
	}

	local filetype = {
		"filetype",
		cond = function()
			return is_file() and vim.o.columns > 100
		end,
	}

	return {
		options = {
			theme = opts["theme"],
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { filename, terminal },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		sections = {
			lualine_a = {
				{
					"diagnostics",
					source = { "nvim" },
					sections = { "error" },
				},
			},
			lualine_b = {
				filename,
			},
			lualine_c = {
				-- has_gps and { gps.get_location, cond = gps.is_available, color = "lualine_c_inactive" } or {},
			},
			lualine_x = { filetype },
			lualine_y = {
				{ "location", icon = "", left_padding = 2, cond = is_file },
				terminal,
			},
			lualine_z = { mode },
		},
	}
end

local function setup()
	local has, lualine = pcall(require, "lualine")
	if not has then
		return
	end

	-- local has_gps, gps = pcall(require, "nvim-gps")
	-- if has_gps then
	-- 	gps.setup({ separator = " ╱ " })
	-- end

	local options = get_theme({ theme = "auto" })
	lualine.setup(options)
end

return { setup = setup }
