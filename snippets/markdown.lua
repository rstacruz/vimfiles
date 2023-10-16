-- See: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
return {
  s("done", {
    f(function()
      local iso = os.date("%Y-%m-%d")
      local m = os.date("%b")
      local d = os.date("%d")
      return string.format("[✓ %s %s](#DoneAt:%s)", d, m, iso)
    end),
  }),

  s("ca", { -- created at
    f(function()
      local iso = os.date("%Y-%m-%d")
      local m = os.date("%b")
      local d = os.date("%d")
      return string.format("[+%s %s](#CreatedAt:%s)", d, m, iso)
    end),
  }),

  s("ica", { -- created at, short
    f(function()
      local iso = os.date("%Y-%m-%d")
      return string.format("[+](#CreatedAt:%s)", iso)
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
