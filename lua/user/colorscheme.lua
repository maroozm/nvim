-- Colorscheme
--------------
-- Example config in lua
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = false
-- vim.g.nord_disable_background = false
-- vim.g.nord_italic = false
-- vim.g.nord_uniform_diff_background = true
-- vim.g.nord_bold = true
vim.g.enfocado_style = "neon"
vim.g.apprentice_contrast_dark = "hard"

-- Load the colorscheme
-- require('nord').set()

local colorscheme = "primer_dark"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
-- require('poimandres').setup {
--   bold_vert_split = false, -- use bold vertical separators
--   dim_nc_background = false, -- dim 'non-current' window backgrounds
--   disable_background = false, -- disable background
--   disable_float_background = false, -- disable background for floats
--   disable_italics = false, -- disable italics
-- }


