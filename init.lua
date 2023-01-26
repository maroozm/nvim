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
  pumheight = 10,                          
  showmode = false,                        
  showtabline = 2,                         
  smartcase = true,                        
  smartindent = true,                      
  splitbelow = true,                       
  splitright = true,                       
  swapfile = false,                        
  termguicolors = true,                    
  timeoutlen = 100,                        
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

--themes
Plug "habamax/vim-saturnite"
Plug "lunarvim/darkplus.nvim"
Plug "rmehri01/onenord.nvim"
Plug "folke/tokyonight.nvim"
Plug "getomni/neovim"

--misc
Plug "junegunn/vim-plug"
Plug "lewis6991/impatient.nvim"
Plug "tpope/vim-commentary"
Plug "karb94/neoscroll.nvim"
Plug "nvim-treesitter/nvim-treesitter"

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
local colorscheme = "omni"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end


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
