-- Lualine
----------
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = false,
}
local filetype = {
  "filetype",
  icons_enabled = false,
}

local filename = {
  "filename",
  path = 3,
}
require('lualine').setup {
  options = {
    globalstatus         = true,
    icons_enabled        = true,
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes   = { "alpha", "dashboard" },
    always_divide_middle = true,
    theme                = 'primer_dark'
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { 'diagnostics', 'filename' },
    lualine_x = { 'diff', 'filetype' },
    lualine_y = { 'location' },
    lualine_z = { "progress" },
  },
}
