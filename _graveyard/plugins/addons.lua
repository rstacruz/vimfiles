return {
  { -- cp-image
    -- Use `:PasteImage`
    "niuiic/cp-image.nvim",
    lazy = true,
    dependencies = { "niuiic/core.nvim" },
    cmd = { "PasteImage" },
    opts = {
      -- These settings are biased towards my Obsidian vaults
      cmd = function(path, image_type)
        if vim.fn.executable("wl-paste") then
          return string.format("wl-paste -t image > %s", path)
        else
          vim.notify("Don't know how to paste, sorry :(")
          return false
        end
      end,
      text = function(relative_path, file_name, file_type, full_path)
        local basename = vim.fn.fnamemodify(file_name, ":t") .. "." .. file_type
        return string.format("![[%s]]", basename)
      end,
      path = function(project_root)
        return project_root .. "/Media"
      end,
    },
  },
}
