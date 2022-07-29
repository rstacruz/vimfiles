local function get_theme(opts)
  local _, gps = pcall(require, "nvim-gps")

  local function is_file()
    local nonfile_types = {
      toggleterm = true,
      NvimTree = true,
      ["neo-tree"] = true,
      startify = true,
      vista_kind = true,
      spectre_panel = true,
    }
    return not (nonfile_types[vim.bo.filetype] or false)
  end

  local terminal = {
    function()
      return [[ ]] .. (vim.b.toggle_number or "0")
    end,
    cond = function()
      return vim.bo.filetype == "toggleterm"
    end,
  }

  local startify = {
    function()
      return [[ ]] .. vim.fn.getcwd()
    end,
    cond = function()
      return vim.bo.filetype == "startify"
    end,
  }

  local filename = {
    "filename",
    icon = "",
    cond = is_file,
    symbols = { modified = " ●", readonly = " " },
  }

  local mode = {
    "mode",
    fmt = function(str)
      return str:sub(1, 1)
    end,
    cond = is_file,
  }
  local tabs = {
    "tabs",
    mode = 0,
    separator = { left = "█", right = "" },
    component_separators = { left = " ", right = "" },
    section_separators = { left = "", right = "" },
    padding = { left = 2, right = 2 },
    tabs_color = {
      -- Same values as the general color option can be used here.
      active = "lualine_a_normal",
      inactive = "lualine_b_inactive",
    },
  }

  local buffers = {
    "buffers",
    -- a  XXXXXX  e   ......
    --    ......      XXXXXX    e    ......
    --    ......  c   ......         XXXXXX   b
    separator = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    padding = { left = 1, right = 4 },
    max_length = 200,
    filetype_names = { NvimTree = "tree" },
    buffers_color = {
      active = "Preproc",
      inactive = "lualine_c_inactive",
    },
  }

  local filetype = {
    "filetype",
    cond = function()
      return is_file() and vim.o.columns > 100
    end,
  }

  return {
    options = {
      theme = opts["theme"],
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename, terminal },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        {
          "diagnostics",
          source = { "nvim" },
          sections = { "error" },
        },
      },
      lualine_c = {
        filename,
        gps and { gps.get_location, cond = gps.is_available, color = "lualine_c_inactive" } or {},
      },
      lualine_x = { filetype },
      lualine_y = {
        { "location", icon = "", left_padding = 2, cond = is_file },
        terminal,
        startify,
      },
      lualine_z = { mode },
    },
    -- tabline = {
    --   lualine_a = { tabs },
    --   lualine_b = {},
    --   lualine_c = { buffers },
    --   lualine_y = {},
    --   lualine_x = {},
    --   lualine_z = {},
    -- },
  }
end

return { get_theme = get_theme }
