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

-- Options
----------
local options = {
  -- pumblend = 17,
  -- wildmode = "longest:full",
  -- wildoptions = "pum",
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
vim.opt.fillchars.eob = " "
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
Plug "lunarvim/darkplus.nvim"
Plug "getomni/neovim"
Plug "lunarvim/lunar.nvim"
Plug 'wuelnerdotexe/vim-enfocado'
Plug 'rktjmp/lush.nvim'
Plug 'rockyzhang24/arctic.nvim'
Plug 'kvrohit/mellow.nvim'

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

Plug 'rebelot/heirline.nvim'
vim.call('plug#end')

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

local colorscheme = "enfocado"
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
    theme                = 'mellow'
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics, filename },
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
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['clangd'].setup {
--   capabilities = capabilities
-- }
-- require 'lspconfig'.lua_ls.setup {}
-- -- require"fidget".setup{}
-- require("mason-lspconfig").setup()
-- local servers = { 'pyright', 'lua_ls' }
-- for _, lsp in pairs(servers) do
--     require('lspconfig')[lsp].setup {
--         on_attach = on_attach,
--         flags = {
--           debounce_text_changes = 150,
--         }
--     }
-- end

-- Keymaps
----------
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>ff', '[[<cmd>Telescope find_files<cr>]]', opts)
--vim.command(inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>")
