vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 10

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.guicursor = "i:block"


local cmp = require'cmp'

cmp.setup({
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
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
       { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },

    })
  })

----  -- Set up lspconfig.
----  local capabilities = require('cmp_nvim_lsp').default_capabilities()
----  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
----  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
----
----    capabilities = capabilities
----  }
----
require("mason").setup()

vim.g.gitblame_enabled = 0

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
