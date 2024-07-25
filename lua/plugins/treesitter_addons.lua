return {
  { -- nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        -- Required for spellcheck, some LaTex highlights and
        -- code block highlights that do not have ts grammar
        additional_vim_regex_highlighting = { "org" },
      },
      ensure_installed = {
        -- default:
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        -- more:
        "mermaid",
        "sql",
        "kdl",
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        -- mdx
        -- https://www.devas.life/effective-neovim-setup-for-web-development-towards-2024/#treesitter
        -- https://joschua.io/posts/2023/06/22/set-up-nvim-for-astro/
        -- not working though :(
        vim.filetype.add({ extension = { mdx = "mdx" } })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },
  },
}
