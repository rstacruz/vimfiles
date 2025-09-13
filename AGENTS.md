# Agent guidelines for this Neovim config

## Code style

- Follow idiomatic Lua and Neovim plugin conventions.
- Use `require("...")` for imports.
- Prefer local modules and functions.
- Use snake_case for variables and functions; PascalCase for modules.
- Use early returns for error handling; avoid exceptions.
- Add `---@param` and similar Lua annotations for types when helpful.
- Keep functions small and descriptive.
- Use descriptive, lowercase file names (e.g., `persist_colorscheme.lua`).

Keymaps:

- For keymap blocks with long lines, use `-- stylua: ignore start` ... `-- stylua: ignore end` comments around them. This prevents line wrapping.

- Avoid inline functions that span more than one line.

  ```lua
  -- avoid
  vim.keymap.set("n", "<leader>xx", function()
    x()
    y()
  end, { desc = "xxx" })

  -- consider
  local function descriptive_name()
    x()
    y()
  end

  vim.keymap.set("n", "<leader>xx", descriptive_name, { desc = "xxx" })
  ```
