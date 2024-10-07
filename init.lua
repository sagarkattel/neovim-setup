-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Enable line numbers and relative numbers
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.mapleader = "\\"
-- Key mapping to toggle Nvim Tree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Use xclip for copying and pasting to system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', ':w !xclip -selection clipboard<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-v>', ':r !xclip -o -selection clipboard<CR>', { noremap = true, silent = true })


-- Lazy.nvim options
local opts = {
    install = {
        colorscheme = { "catppuccin" },
    },
}

-- Plugin configuration
local plugins ={
    { 'xiyaowong/transparent.nvim', lazy = false },
    
    -- Catppuccin color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd("colorscheme catppuccin")
            require("catppuccin").setup({
                transparent_background = true,
            })
        end,
    },
    
    -- Nvim-tree plugin
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        config = function()
            require("nvim-tree").setup({
                view = { width = 30 },
                renderer = {
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = "▸",  -- closed arrow
                                arrow_open = "▾",    -- open arrow
                                default = "📁",      -- default folder icon
                                open = "📂",         -- open folder icon
                                empty = "📁",        -- empty folder
                                empty_open = "📂",   -- empty open folder
                                symlink = "🔗",      -- symlink folder
                            },
                        },
                    },
                },
                filters = { dotfiles = false },
            })
        end,
    },

    -- FZF and fzf.vim integration
    {
        "junegunn/fzf",  -- FZF binary
        run = function() vim.fn["fzf#install"]() end  -- Ensure FZF is installed
    },
    {
        "junegunn/fzf.vim",  -- FZF Vim integration
        config = function()
            -- Optional: Customize FZF options here
        end,
    }
}

-- Key mapping for FZF search
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true, silent = true })  -- Search files
vim.api.nvim_set_keymap('n', '<leader>fw', ':Rg<CR>', { noremap = true, silent = true })    -- Search words

require("lazy").setup(plugins, opts)

