local function setup()
  local has, toggleterm = pcall(require, "toggleterm")
  if not has then return end

  toggleterm.setup({
    direction = "vertical",
    size = function(term)
      if term.direction == "horizontal" then
        return 24
      elseif term.direction == "vertical" then
        return 80 -- vim.o.columns * 0.4
      end
    end,
    shading_factor = 3,
  })
end

return { setup = setup }
