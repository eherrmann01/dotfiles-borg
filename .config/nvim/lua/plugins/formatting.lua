--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim formatting configuration file, updated 12/13/2024
-- ~/.config/nvim/lua/plugins/formatting.lua

return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require 'conform'

        conform.setup {
            formatters_by_ft = {
                javascript = { 'prettier' },
                typescript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescriptreact = { 'prettier' },
                svelte = { 'prettier' },
                css = { 'prettier' },
                --                html = { 'prettier' },
                json = { 'prettier' },
                yaml = { 'prettier' },
                markdown = { 'prettier' },
                graphql = { 'prettier' },
                liquid = { 'prettier' },
                lua = { 'stylua' },
                python = { 'isort', 'black' },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        }

        vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
            conform.format {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            }
        end, { desc = 'Format file or range (in visual mode)' })
    end,
}
