local indent = 5

return {
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = function()
      local logo = ""
      local pad = string.rep(" ", indent)

      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")

      local config = {
        evaluate_single = true,
        header = logo,
        items = {
          new_section("e new file", "ene | startinsert", ""),
          new_section("p open file...", "Telescope git_files", ""),
          new_section("_ explore...", [[lua require("mini.files").open()]], ""),
          new_section("r session restore", [[lua require("persistence").load()]], ""),
          new_section("q exit", "qa", " "),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
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
          local pad_footer = string.rep(" ", indent + 2)
          starter.config.footer = pad_footer .. "" .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
