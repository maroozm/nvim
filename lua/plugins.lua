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
