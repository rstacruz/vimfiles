# luasnip codesnippets loader

Loads code snippets from a project automatically. Supports vscode's `.vscode/*.code-snippets`.

## Usage

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```
  {
    "rstacruz/?????",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
```
