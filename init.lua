vim.g.mapleader = " "

-- Basic Vim options
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.cmdheight = 0
vim.opt.showtabline = 0
vim.opt.termguicolors = true
vim.opt.background = 'light' -- Set light mode
-- Transparent background
vim.cmd([[
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
  highlight NormalNC ctermbg=none guibg=none
  highlight VertSplit ctermbg=none guibg=none
  highlight StatusLine ctermbg=none guibg=none
  highlight StatusLineNC ctermbg=none guibg=none
]])

-- Lazy.nvim setup (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Colorschemes
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        dark_variant = 'main',
        disable_background = true,
      })
    end,
  },
  { "EdenEast/nightfox.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- Light variant as main theme
        transparent_background = true,
      })
    end,
  },
  { "dracula/vim", name = "dracula" },
  { "shaunsingh/nord.nvim" },
  { "navarasu/onedark.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "morhetz/gruvbox" },
  {
    'tanvirtin/monokai.nvim',
    name = 'monokai',
    lazy = false,
    priority = 1000,
    config = function()
      require('monokai').setup({
        transparent = true,
      })
    end,
  },
  -- Light themes
  { "folke/tokyonight.nvim" }, -- Already included
  { "sainnhe/everforest" },   -- Already included
  { "ellisonleao/gruvbox.nvim" }, -- Already included

  -- Additional 5 Light & Dark Themes
  {
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_style = 'andromeda' -- Dark variant
      vim.g.sonokai_transparent_background = 1
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = true,
        theme = "wave", -- Dark variant
      })
    end,
  },
  {
    "NLKNguyen/papercolor-theme",
    config = function()
      vim.g.PaperColor_Theme_Options = {
        theme = {
          default = { allow_transparent = 1 }
        }
      }
    end,
  },
  {
    "marko-cerovac/material.nvim",
    config = function()
      require('material').setup({
        disable_background = true,
        style = "lighter", -- Light variant
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_transparent_background = 1
    end,
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",  -- Match main theme
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        }
      })
    end
  },

  -- LSP and Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({})

      vim.keymap.set("n", "<leader>pf", function()
        print("Telescope: Finding files in Projects")
        builtin.find_files({ 
          cwd = vim.fn.expand("~/Documents/Projects"),
        })
      end, { noremap = true, silent = false })

      vim.keymap.set("n", "<C-p>", function()
        builtin.git_files({ 
          cwd = vim.fn.expand("~/Documents/Projects") 
        })
      end, { noremap = true, silent = true })
    end,
  },

  -- Harpoon
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      require("harpoon").setup()

      vim.keymap.set("n", "<leader>a", function()
        print("Harpoon: Adding file")
        mark.add_file()
      end, { noremap = true, silent = false })

      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { noremap = true, silent = true })
    end,
  },
  
  -- TreeSitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
})

-- Autocomplete configuration
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Enter>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
})

-- LSP Configurations
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({ 
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  }
})

require("lspconfig").cmake.setup({ capabilities = capabilities })
require("lspconfig").html.setup({ capabilities = capabilities })
require("lspconfig").cssls.setup({ capabilities = capabilities })

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Customize status line colors
vim.api.nvim_set_hl(0, "StatusLine", { bg = "white", fg = "black" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "white", fg = "gray" })
vim.cmd.colorscheme "elflord" -- Set as main theme
