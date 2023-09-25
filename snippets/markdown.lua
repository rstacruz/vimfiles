-- See: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
return {
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
