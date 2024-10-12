return {
  { -- Origami
    -- `h` to fold (at first non-blank char)
    -- `l` to unfold
    -- remember fold across sessions
    -- unfold when searching
    "chrisgrieser/nvim-origami",
    lazy = true,
    event = "BufReadPost",
    opts = true,
    -- stylua: ignore
    keys = {
      { "<Right>", function() require("origami").l() end, "Right or unfold" },
      -- { "<Left>", function() require("origami").h() end, "Left or unfold" },
    }
,
  },
}
