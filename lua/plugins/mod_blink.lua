local is_termux = string.find(vim.loop.os_uname().release, "android")

return {
  { "saghen/blink.cmp", enabled = not is_termux },
}
