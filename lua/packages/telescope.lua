local M = { -- telescope: file picker UI
	"nvim-telescope/telescope.nvim",
	-- cmd = "Telescope",
	-- module = "telescope",
	-- Ideally :cmd should take care of lazy-loading, but it has problems with
	-- hot reloading
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
		"nvim-telescope/telescope-z.nvim",
		-- alt-c / c  create
		-- alt-r / r create
		"nvim-telescope/telescope-file-browser.nvim",
		"marcuscaisey/olddirs.nvim",
	},
}

function M.config()
	local telescope = require("telescope")

	local options = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			prompt_prefix = "   ",
			selection_caret = "› ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.4,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			-- file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "truncate" },
			winblend = 0,
			border = true,
			-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			color_devicons = true,
			-- set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
			},
		},
		extensions = {
			file_browser = {
				-- theme =ivy "ivy",
			},
		},
	}

	telescope.setup(options)

	pcall(function()
		telescope.load_extension("fzf")
	end)

	pcall(function()
		telescope.load_extension("projects")
	end)

	pcall(function()
		telescope.load_extension("z")
	end)

	pcall(function()
		telescope.load_extension("file_browser")
	end)

	pcall(function()
		telescope.load_extension("olddirs")
	end)
end

return M
