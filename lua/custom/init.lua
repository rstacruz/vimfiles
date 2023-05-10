-- Example: load from a file outside the vim path
-- vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/../ursavim/init.lua")

-- BaseConfig.ui.theme_dark = "terafox" -- terafox | github_dimmed | catppuccin
-- BaseConfig.ui.theme_light = "github_light"

-- BaseConfig.features.auto_cd_root = true
-- BaseConfig.features.lsp = true
-- BaseConfig.features.lsp_installer = true
-- BaseConfig.features.completions = true
-- BaseConfig.features.treesitter = true
-- BaseConfig.features.github_fugitive = true
-- BaseConfig.features.gitsigns = true
-- BaseConfig.features.indent_guides = true
-- BaseConfig.features.hop = true
-- BaseConfig.features.file_explorer = true
-- BaseConfig.features.autopairs = true
-- BaseConfig.features.gitsigns = true
-- BaseConfig.features.indent_detection = true
-- BaseConfig.features.indent_guides = true
-- BaseConfig.features.scrollbars = true
-- BaseConfig.features.workspaces = true
-- BaseConfig.features.alternate_filetypes = false
-- BaseConfig.features.treesitter_playground = true
-- BaseConfig.features.status_line = true
-- BaseConfig.features.zk = false
BaseConfig.features.zk = true

-- BaseConfig.format.autoformat_files = "*.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs",

-- BaseConfig.treesitter.ensure_installed = { "lua" }
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "javascript", "jsdoc", "json", "typescript" })
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "css", "html", "scss" })
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "ruby" })
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "scss" })
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "python" })
-- vim.list_extend(BaseConfig.treesitter.ensure_installed, { "make", "markdown" })

-- BaseConfig.terminal.shell = nil
-- BaseConfig.terminal.shell = "fish"

-- ## Plugin setup overrides
-- These can be tables (will be extended) of functions (will be passed the config)
-- BaseConfig.plugins.nvim_tree = {}
-- BaseConfig.plugins.nvim_surround = {}
-- BaseConfig.plugins.nvim_autopairs = {}
-- BaseConfig.plugins.navic = {}
-- BaseConfig.plugins.neogit = {}
