-- assumes the `test.core` extra in Lazyvim
-- https://www.lazyvim.org/extras/test/core
--
-- For test runners:
-- https://github.com/nvim-neotest/neotest#supported-runners
--
-- Quick start guide:
--   leader tt - run test in this file
--   leader ts - how summary
--   [n ]n - next test failure
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "MarkEmmons/neotest-deno",
    },
    opts = {
      adapters = { ["neotest-plenary"] = {}, ["neotest-jest"] = {}, ["neotest-vitest"] = {}, ["neotest-deno"] = {} },
    },
  },
}
