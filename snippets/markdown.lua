-- See: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
local luasnip = require("luasnip")
local snippet = luasnip.snippet
local fn = luasnip.function_node
local ins = luasnip.insert_node
local format = require("luasnip.extras.fmt").fmt

return {
  snippet(
    { trig = "url", desc = "Insert link from clipboard" },
    format("[{title}]({url})", {
      title = ins(1, "Title"),
      url = fn(function()
        return "..."
      end),
    })
  ),

  snippet({ trig = "ca", desc = "Add current date" }, {
    fn(function()
      local iso = os.date("%Y-%m-%d")
      local m = os.date("%b")
      local d = os.date("%d")
      return string.format("[[%s|%s %s]]", iso, d, m)
    end),
  }),

  -- Write out H1
  snippet(
    { trig = "xh1", desc = "Insert H1 with title" },
    format("# {title}", {
      title = fn(function()
        local filename = vim.fn.expand("%:t")
        local heading = filename
        heading = heading:gsub(".md", "")
        heading = heading:gsub("^%d%d%d%d ", "")
        return heading
      end),
    })
  ),
}
