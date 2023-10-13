-- Removed: flash.nvim is pretty good
return {
  {
    "echasnovski/mini.jump2d",
    version = "*",
    opts = {
      labels = "arstgoiendhgmcplfuwybjx", -- colemak-dh bias, no pinkies
      view = {
        n_steps_ahead = 2, -- show more chars rather than just one
      },
      allowed_windows = {
        not_current = false, -- only show on current window
      },
    },
    lazy = true,
    config = function(_, opts)
      require("mini.jump2d").setup(opts)
    end,
    keys = {
      {
        "gl",
        function()
          MiniJump2d.start(MiniJump2d.builtin_opts.line_start)
        end,
        desc = "Go to line",
        mode = { "n", "v" },
      },
      {
        "gm",
        function()
          MiniJump2d.start(MiniJump2d.builtin_opts.word_start)
        end,
        desc = "Go to word",
        mode = { "n", "v" },
      },
      {
        "g!",
        function()
          MiniJump2d.start({
            spotter = MiniJump2d.gen_pattern_spotter("['\"`]"),
          })
        end,
        desc = "Go to quote",
        mode = { "n", "v" },
      },
    },
  }
