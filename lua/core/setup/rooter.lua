local function setup()
  -- Localise the changes, so, eg, opening vimrc while in a project will
  -- not mess with the global cwd
  vim.g.rooter_cd_cmd = "lcd"
  vim.g.rooter_silent_chdir = 1

  -- simplify the list for optimisation
  vim.g.rooter_patterns = { ".git", "package.json" }
end

return { setup = setup }
