# Examples

```lua
return {
  "pwntester/octo.nvim",
  event = "VeryLazy",
  opts = {
    -- options can be placed here instead of using `config`
  },
  init = function ()
    -- idk
  end,
  config = function()
    require("octo").setup({})
  end,
}
```

## Links

Some other examples from the web:

- https://github.com/folke/lazy.nvim#-plugin-spec
- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
