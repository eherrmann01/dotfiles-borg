--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim configuration file, updated 12/14/2024
-- ~/.config/nvim/init.lua

require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

-- Automatically save and load views
vim.cmd [[
  augroup auto_load_views
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]]

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '', -- You can use ⛔ or any icon
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
}

vim.opt.rtp:prepend(lazypath)
vim.g.zenbones_compat = 1
-- vim.cmd.colorscheme 'zenbones'

-- Load plugins
require('lazy').setup {
    require 'plugins.alpha',
    require 'plugins.autocompletion',
    require 'plugins.autopairs',
    require 'plugins.bufferline',
    require 'plugins.debug',
    require 'plugins.formatting',
    require 'plugins.gitsigns',
    require 'plugins.image',
    require 'plugins.indent-blankline',
    require 'plugins.lint',
    require 'plugins.lspconfig',
    require 'plugins.lualine',
    require 'plugins.mason',
    require 'plugins.mini',
    require 'plugins.misc',
    require 'plugins.neogit',
    require 'plugins.neotree',
    require 'plugins.telescope',
    require 'plugins.markdown',
    require 'plugins/themes.nord', -- To change theme, put the theme in /lua/plugins/themes and change the name here.
    -- require 'plugins/themes.zenbones',
    require 'plugins.todo-comments',
    require 'plugins.treesitter',
}

--Hide line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
