local function get_borders(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local function setup()
  local has_cmp, cmp = pcall(require, "cmp")
  if not has_cmp then
    return
  end

  local has_lspkind, lspkind = pcall(require, "lspkind")
  local formatting = has_lspkind and {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
    }),
  } or {}

  local mapping = cmp.mapping.preset.insert({
    ["<cr>"] = cmp.mapping.confirm(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
  })

  cmp.setup({
    window = {
      completion = {
        border = get_borders("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = get_borders("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
    },
    mapping = mapping,
    formatting = formatting,
    completion = {
      keyword_length = 2,
    },
    -- snippet = {
    --   expand = function()
    --     -- vim.fn["vsnip#anonymous"](args.body)
    --   end,
    -- },
    sources = cmp.config.sources({
      -- { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return { setup = setup }
