vim.g.mapleader = " "
vim.opt.guicursor = ""
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
vim.opt.background = 'dark'
vim.opt.cmdheight = 0
vim.opt.showtabline = 0

-- Lazy.nvim setup
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

-- Load plugins with Lazy.nvim
require("lazy").setup({
    -- colorschemes

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        dark_variant = 'main',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
          background = 'black',
          background_nc = '_experimental_nc',
          panel = 'surface',
          panel_nc = 'base',
          border = 'highlight_med',
          comment = 'muted',
          link = 'iris',
          punctuation = 'subtle',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',

          headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
          }
        },

        -- Change specific vim highlight groups
        highlight_groups = {
          ColorColumn = { bg = 'rose' }
        }
      })

      -- Set colorscheme after options
      vim.cmd('colorscheme rose-pine')
    end,
  },
    { "EdenEast/nightfox.nvim" },
    { "dracula/vim", name = "dracula" },
    { "shaunsingh/nord.nvim" },
    { "navarasu/onedark.nvim" },
    { "Mofiqul/vscode.nvim" },
    { "projekt0n/github-nvim-theme" },
    { "joshdick/onedark.vim", name = "quiet" },
    { "morhetz/gruvbox" },
  {
    'tanvirtin/monokai.nvim',
    name = 'monokai',
    lazy = false,
    priority = 1000,
    config = function()
      require('monokai').setup({
        -- Monokai theme options
        background = 'black', -- Set background to dark
        custom_colors = {
          -- Customize specific colors
          bg = '#000000', -- Set background color to black
          fg = '#f8f8f2', -- Set foreground (text) color
        },
        styles = {
          -- Customize text styles
          comments = 'italic',
          keywords = 'bold',
          functions = 'italic,bold',
        },
        -- Other configuration options
        transparent = false,
        term_colors = true,
        dim_inactive = false,
        colorcolumn = '80',
      })

      -- Set the Monokai colorscheme
      vim.cmd('colorscheme monokai')
    end,
  },
    { "Yagua/nebulous.nvim", name = "reblot" },
    { "oxfist/night-owl.nvim"},
    -- Evil lualine for status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "nord",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                }
            })
        end
    },

    -- Plugins for C/C++ Autocompletion
    { 'neovim/nvim-lspconfig' },       -- LSP configuration
    { 'hrsh7th/nvim-cmp' },            -- Autocompletion plugin
    { 'hrsh7th/cmp-nvim-lsp' },        -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },          -- Buffer completions
    { 'hrsh7th/cmp-path' },            -- Path completions
    { 'L3MON4D3/LuaSnip' },            -- Snippet engine
    { 'saadparwaiz1/cmp_luasnip' },    -- Snippet completions

    -- Telescope for fuzzy finding
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            -- Set up Telescope with default settings
            telescope.setup({
                defaults = {
                    -- You can add default settings here if needed
                },
            })

            -- Specify the search directory
            local search_dir = vim.fn.expand("~/Desktop/Programming/NeoVim")

            -- Key mappings for Telescope with the restricted search directory
            vim.keymap.set("n", "<leader>pf", function()
                builtin.find_files({ cwd = search_dir })
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<C-p>", function()
                builtin.git_files({ cwd = search_dir })
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>pws", function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word, cwd = search_dir })
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>pWs", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word, cwd = search_dir })
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > "), cwd = search_dir })
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>vh", function()
                builtin.help_tags({ cwd = search_dir })
            end, { noremap = true, silent = true })
        end,
    },

    -- Harpoon for file navigation
    {
        "theprimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            require("harpoon").setup()

            -- Key mappings for Harpoon
            vim.keymap.set("n", "<leader>a", mark.add_file, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { noremap = true, silent = true })

            -- Navigation mappings for the first four files
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { noremap = true, silent = true })
        end,
    },

    -- Autocomplete configuration
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Down>"] = cmp.mapping.select_next_item(),
                    ["<Enter>"] = cmp.mapping.confirm({ select = true })
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                }
            })
            require("lspconfig").clangd.setup {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }
        end
    }
})

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Set up the status line colors
vim.api.nvim_set_hl(0, "StatusLine", { bg = "black", fg = "white" })  -- Adjust fg as needed
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "black", fg = "gray" })  -- Adjust fg as needed

-- Set colorscheme (choose one)
vim.cmd("colorscheme rose-pine") -- change this line to any of the colorschemes you prefer

-- End of init.lua
