--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim miscellaneous plugins configuration file, updated 12/08/2024
-- ~/.config/nvim/lua/plugins/misc.lua
-- Standalone plugins with less than 10 lines of config go here

return {
    {
        -- tmux & split window navigation
        'christoomey/vim-tmux-navigator',
    },
    {
        -- autoclose tags
        'windwp/nvim-ts-autotag',
    },
    {
        -- detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
    },
    {
        -- Powerful Git integration for Vim
        'tpope/vim-fugitive',
    },
    {
        -- GitHub integration for vim-fugitive
        'tpope/vim-rhubarb',
    },
    {
        -- Hints keybinds
        'folke/which-key.nvim',
        opts = {
            -- win = {
            --   border = {
            --     { '┌', 'FloatBorder' },
            --     { '─', 'FloatBorder' },
            --     { '┐', 'FloatBorder' },
            --     { '│', 'FloatBorder' },
            --     { '┘', 'FloatBorder' },
            --     { '─', 'FloatBorder' },
            --     { '└', 'FloatBorder' },
            --     { '│', 'FloatBorder' },
            --   },
            -- },
        },
    },
    {
        -- Autoclose parentheses, brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        opts = {},
    },
    {
        -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        -- high-performance color highlighter
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
}
