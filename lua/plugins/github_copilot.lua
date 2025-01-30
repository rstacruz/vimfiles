if not vim.g.use_official_github_copilot then
  return {}
end

return {
  { "github/copilot.vim", event = "LazyFile" },
}
