local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    {'f-person/git-blame.nvim'},
    {url = 'https://gitlab.com/huesersohn/sonarlint.nvim'}
    , { "nvim-lua/plenary.nvim" }
, { 'nvim-tree/nvim-web-devicons' }
, { "nvim-telescope/telescope.nvim" }
, { "windwp/nvim-autopairs" }
, { "mbbill/undotree" }
,{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
, { 'simrat39/rust-tools.nvim' }
, { "nvim-treesitter/nvim-treesitter" }
, { "romgrk/nvim-treesitter-context" }
, { "ThePrimeagen/harpoon" }
, { 'nvim-telescope/telescope-ui-select.nvim' }
, { "mfussenegger/nvim-dap" }
, { "mfussenegger/nvim-jdtls" }
, { "rcarriga/nvim-dap-ui" }
, { "theHamsta/nvim-dap-virtual-text" }
, { 'RRethy/vim-illuminate' }
, { 'nvim-lualine/lualine.nvim' },
 {'VonHeikemen/lsp-zero.nvim', branch = 'v2.x'},
{ 'neovim/nvim-lspconfig' },
{
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
},
{ 'williamboman/mason-lspconfig.nvim' }, 
{ 'hrsh7th/nvim-cmp' },
{ 'hrsh7th/cmp-nvim-lsp' },
{ 'L3MON4D3/LuaSnip' },
{ 'arkav/lualine-lsp-progress' }
})
require'user'
