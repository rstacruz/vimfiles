return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    vscode = false,
    opts = function(_, opts)
      opts.winopts.width = 0.9 -- from 0.8
      opts.winopts.height = 0.9 -- from 0.8
    end,
  },
}
