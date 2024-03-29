return {
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    enabled = false,
    event = "VimEnter",
    opts = function()
      local logo = ""

      local new_section = function(name, action, section)
        return { name = name, action = action, section = section }
      end

      local starter = require("mini.starter")

      local config = {
        -- Don't wait for extra <cr> to confirm actions
        evaluate_single = true,

        header = function()
          return "" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,

        items = {
          new_section("e new file", "ene | startinsert", "Actions"),
          new_section("p open file...", "Telescope git_files", "Actions"),
          new_section("_ explore...", [[lua require("mini.files").open()]], "Actions"),
          new_section("r session restore", [[lua require("persistence").load()]], "Actions"),
          starter.sections.recent_files(6, true),
          new_section("q exit", "qa", "Neovim"),
        },

        content_hooks = {
          starter.gen_hook.adding_bullet("░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,

    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 2)
          starter.config.footer = pad_footer .. "" .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
