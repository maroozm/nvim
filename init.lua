-- Setup augroup to make this config reloadable at runtime
local init_lua_augroup = vim.api.nvim_create_augroup('init.lua', {})
-- Define some helper functions
local function makeAutocommandOpts(vim_command_or_lua_callback)
  if type(vim_command_or_lua_callback) == 'string' then
    return { command = vim_command_or_lua_callback }
  else
    return { callback = vim_command_or_lua_callback }
  end
end
local function addAutocommand(events, pattern, vim_command_or_lua_callback)
  local opts = makeAutocommandOpts(vim_command_or_lua_callback)
  vim.api.nvim_create_autocmd(events, vim.fn.extend(opts, {
    pattern = pattern, group = init_lua_augroup
  }))
end
local function addFiletypeAutocommand(filetype, vim_command_or_lua_callback)
  addAutocommand('FileType', filetype, vim_command_or_lua_callback)
end
local function addBufferAutocommand(events, vim_command_or_lua_callback)
  local opts = makeAutocommandOpts(vim_command_or_lua_callback)
  vim.api.nvim_create_autocmd(events, vim.fn.extend(opts, { buffer = 0 }))
end
local function mapToCommand(keys, vim_command)
  vim.keymap.set('n', keys, function()
    vim.api.nvim_command(vim_command)
  end, { silent = true })
end

-- Reload this config when it's saved to disk
local init_lua_path = vim.fn.stdpath('config') .. '/init.lua'
addAutocommand('BufWritePost', init_lua_path, function() dofile(init_lua_path) end)

vim.loader.enable()

-- Options
----------
require "options"

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
Plug "lunarvim/darkplus.nvim"
Plug "lunarvim/lunar.nvim"
Plug 'rktjmp/lush.nvim'
Plug 'LunarVim/primer.nvim'
--indentline
Plug 'lukas-reineke/indent-blankline.nvim'
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
Plug 'kvrohit/mellow.nvim'
Plug "hrsh7th/cmp-path"
Plug 'hrsh7th/cmp-cmdline'
Plug "saadparwaiz1/cmp_luasnip"
Plug "hrsh7th/cmp-nvim-lua"
--comment
Plug 'numToStr/Comment.nvim'
--lsp
--Plug('j-hui/fidget.nvim', {'tag': 'legacy' })
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
--fuzzyfinder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = vim.fn['make'] })
Plug 'smartpde/telescope-recent-files'
--copilot
Plug 'github/copilot.vim'
--toggleterm
Plug 'akinsho/toggleterm.nvim'
--winbar
Plug 'SmiteshP/nvim-navic'
Plug 'LunarVim/breadcrumbs.nvim'

Plug 'rebelot/heirline.nvim'
vim.call('plug#end')


require "colorscheme"
require "lualine"
require "telescope"
-- Netrw config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_localrmdir = 'rm -rf'

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
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
local cmp = require 'cmp'
require("which-key").setup {}
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

require 'cmp'.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = "buffer" },
    { name = "nvim_lua" },
  }
}

-- LSP
----------
---- Set up lspconfig.
--local capabilities = vim.lsp.protocol.make_client_capabilities()
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require'mason'.setup{}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
vim.diagnostic.config({ virtual_text = false })

-- toggleterm
require("toggleterm").setup {
 size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    float_opts = {
      border = "rounded",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.count
      end,
    },
}

--navic
local icons = require "icons"
  require("nvim-navic").setup {
    icons = icons.kind,
    highlight = true,
    lsp = {
      auto_attach = true,
    },
    click = true,
    separator = " " .. icons.ui.ChevronRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
  }
require("breadcrumbs").setup {}


  -- Keymaps
----------
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>ff', '[[<cmd>Telescope find_files<cr>]]', opts)
--vim.command(inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>")
