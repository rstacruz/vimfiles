local State = {
	mode = "dark",
}

local function get_lightness_from_wal()
	local cache = vim.env.XDG_CACHE_DIR or (vim.env.HOME .. "/.cache")

	-- Pywal colors file
	local colors_file = cache .. "/wal/colors"
	if vim.fn.filereadable(colors_file) == 0 then
		return nil
	end

	local bgcolor = vim.fn.readfile(colors_file, "", 1)[1]
	return vim.fn.matchstr(bgcolor, "#[efEF]") ~= "" and "light" or "dark"
end

local function get_lightness()
	return get_lightness_from_wal() or vim.opt.background:get()
end

local function apply(mode)
	local colorscheme = nil
	if mode == "dark" then
		colorscheme = BaseConfig.ui.theme_dark
	else
		colorscheme = BaseConfig.ui.theme_light
	end

	-- Lazy-laod the colors
	vim.notify("Color: " .. colorscheme .. " (" .. mode .. ")")

	vim.cmd("doautocmd User Color_" .. colorscheme)
	vim.opt.background = mode
	vim.cmd("colorscheme " .. colorscheme)

	State.mode = mode
end

local function setup()
	-- Workaround for background detection
	-- https://github.com/neovim/neovim/issues/17070#issuecomment-1086775760
	-- if vim.env.TMUX then
	--   vim.loop.fs_write(2, "\27Ptmux;\27\27]11;?\7\27\\", -1, nil)
	-- end

	apply(get_lightness())
end

local function toggle_theme()
	local mode = State.mode == "dark" and "light" or "dark"
	apply(mode)
end

return { setup = setup, toggle_theme = toggle_theme }
