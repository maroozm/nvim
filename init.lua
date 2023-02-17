-- Options
----------
local options = {
  pumblend = 17,
  wildmode = "longest:full",
  wildoptions = "pum",
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
 -- showtabline = 2,                         
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
  relativenumber = true,                  
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
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

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
Plug 'shaunsingh/nord.nvim'
Plug "lunarvim/darkplus.nvim"
Plug "getomni/neovim"
Plug "olivercederborg/poimandres.nvim"
Plug "lunarvim/lunar.nvim"
Plug "gs/muon-dark"
Plug 'rktjmp/lush.nvim'
Plug 'rockyzhang24/arctic.nvim'
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
Plug "L3MON4D3/LuaSnip"
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
Plug 'smartpde/telescope-recent-files'
vim.call('plug#end')

-- Colorscheme
--------------
-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true

-- Load the colorscheme
require('nord').set()

local colorscheme = "arctic"
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
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
    theme  = 'darkplus' 
  },
   sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics, filename},
    lualine_x = { 'diff', filetype },
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
require("telescope").load_extension("recent_files")

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
local cmp = require'cmp'
require("which-key").setup { }
local wk = require("which-key")

wk.register({
  ["<leader>f"] = { name = "Telescope" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Search through files" },
  ["<leader>fr"] = { "<cmd>lua require('telescope').extensions.recent_files.pick()<cr>", "Open Recent File" },
  ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  ["<leader>w"] = { "<cmd>NvimTreeToggle<cr>", "File Manager" },
  ["<leader>c"] = { "<cmd>Commentary<cr>", "Comment Lines" },
})

require'cmp'.setup {
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
     mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  sources = {
    { name = luasnip },
    { name = 'path' },
    { name = "buffer" },
  },
}

-- Keymaps
----------
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>ff', '[[<cmd>Telescope find_files<cr>]]', opts)
