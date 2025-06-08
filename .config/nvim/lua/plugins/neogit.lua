--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim NeoGit file, updated 12/15/2024
-- ~/.config/nvim/lua/plugins/neogit.lua
return {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    command = 'Neogit',
    config = function()
        require('neogit').setup {
            integrations = {
                diffview = true,
            },
        }
    end,
}
