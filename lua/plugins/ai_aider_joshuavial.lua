if vim.g.disable_ai_plugins == 1 then
  return {}
end

return {
  {
    "joshuavial/aider.nvim",
    cmd = { "AiderOpen", "AiderAddModifiedFiles" },
    vscode = false,
    event = "LazyFile",
    opts = {},
  },
}
