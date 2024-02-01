-- See: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
return {
  s("done", {
    f(function()
      local iso = os.date("%Y-%m-%d")
      local m = os.date("%b")
      local d = os.date("%d")
      return string.format("[[%s#DoneAt|%s %s ✓]]", iso, d, m)
    end),
  }),

  s("ca", { -- created at
    f(function()
      local iso = os.date("%Y-%m-%d")
      local m = os.date("%b")
      local d = os.date("%d")
      return string.format("[[%s|%s %s]]", iso, d, m)
    end),
  }),

  -- Write out H1
  s("xh1", {
    t("# "),
    f(function()
      local filename = vim.fn.expand("%:t")
      local heading = filename
      heading = heading:gsub(".md", "")
      heading = heading:gsub("^%d%d%d%d ", "")
      return heading
    end),
    t({ "", "" }),
  }),
}
