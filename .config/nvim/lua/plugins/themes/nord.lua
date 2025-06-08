--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim Nord colortheme configuration file, updated 12/08/2024
-- ~/.config/nvim/plugins/themes/nord.lua

-- Nord theme
return {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = false
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false

        -- Load the colorscheme
        require('nord').set()

        local bg_transparent = true

        -- Toggle background transparency
        local toggle_transparency = function()
            bg_transparent = not bg_transparent
            vim.g.nord_disable_background = bg_transparent
            vim.cmd [[colorscheme nord]]
            -- set_menu_border_transparency()
        end
        vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
    end,
}
