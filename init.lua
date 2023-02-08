-- Options
----------
local options = {
  backup = false,                          
  clipboard = "unnamedplus",               
--  cmdheight = 2,                         
  completeopt = { "menuone", "noselect" }, 
  conceallevel = 0,                        
  fileencoding = "utf-8",                  
  hlsearch = true,                         
  ignorecase = true,                       
  mouse = "a",                             
  pumheight = 1,                          
  showmode = false,                        
  showtabline = 2,                         
  smartcase = true,                        
  smartindent = true,                      
  splitbelow = true,                       
  splitright = true,                       
  swapfile = false,                        
  termguicolors = true,                    
  timeoutlen = 500,                        
  undofile = true,                         
  updatetime = 300,                        
  writebackup = false,                     
  expandtab = true,                        
  shiftwidth = 2,                          
  tabstop = 2,                             
  cursorline = true,                       
  number = true,                           
  laststatus = 3,
  relativenumber = false,                  
  numberwidth = 4,                         
  signcolumn = "yes",                      
  wrap = true,                            
  scrolloff = 8,                           
  sidescrolloff = 8,
  guifont = "monospace:h17",               

}
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.fillchars.eob=" "
-- use space as leader key
vim.g.mapleader = " "
vim.opt.shortmess:append "c"
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Plugins
-- -------
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
--filemanager
Plug 'nvim-tree/nvim-tree.lua'
--lualine
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
--themes
Plug "habamax/vim-saturnite"
Plug "lunarvim/darkplus.nvim"
Plug "rmehri01/onenord.nvim"
Plug "folke/tokyonight.nvim"
Plug "getomni/neovim"
Plug "olivercederborg/poimandres.nvim"
Plug "lunarvim/lunar.nvim"
--misc
Plug "junegunn/vim-plug"
Plug "lewis6991/impatient.nvim"
Plug "tpope/vim-commentary"
Plug "karb94/neoscroll.nvim"
Plug "nvim-treesitter/nvim-treesitter"
Plug "folke/which-key.nvim"
--gitsigns
Plug "lewis6991/gitsigns.nvim"
--completions
Plug "hrsh7th/nvim-cmp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "saadparwaiz1/cmp_luasnip"
Plug "hrsh7th/cmp-nvim-lua"
--comment
Plug 'numToStr/Comment.nvim'
--fuzzyfinder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = vim.fn['make']})
vim.call('plug#end')

-- Colorscheme
--------------
local colorscheme = "lunar"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
require('poimandres').setup {
  bold_vert_split = false, -- use bold vertical separators
  dim_nc_background = false, -- dim 'non-current' window backgrounds
  disable_background = false, -- disable background
  disable_float_background = false, -- disable background for floats
  disable_italics = false, -- disable italics
}

-- Lualine
----------
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}
local filetype = {
  "filetype",
  icons_enabled = false,
}

require('lualine').setup {
  options = {
     globalstatus = true,
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
    theme  = 'lunar' 
  },
   sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}

-- Telescope config
--------------
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
pcall(require('telescope').load_extension, 'fzf')

-- Netrw config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Plugins setups
-----------------
require("which-key").setup { }
require'cmp'.setup {
  sources = {
    { name = 'path' },
    { name = "buffer" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

-- Keymaps
----------
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>k', ':WhichKey<cr>')
vim.keymap.set('n', '<leader>w', ':NvimTreeToggle<cr>')
