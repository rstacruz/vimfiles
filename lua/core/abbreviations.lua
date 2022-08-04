local ABBREVIATIONS = {
  COnfig = "Config",
  CONfig = "Config",
  cosnt = "const",
  fnuction = "function",
}

local function setup()
  for left, right in pairs(ABBREVIATIONS) do
    vim.cmd("iabbrev " .. left .. " " .. right)
  end
end

return {
  setup = setup,
  abbreviations = ABBREVIATIONS
}
