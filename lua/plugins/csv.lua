return {
  {
    "hat0uma/csvview.nvim",
    ft = { "text", "tsv", "csv" },
    cmd = { "CsvViewToggle", "CsvViewEnable", "CsvViewDisable" },
    config = function()
      require("csvview").setup()
    end,
  },
}
