return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup {
            derfault_file_permissions = 'rw-r--r--',
            default_file_explorer = true,
            keymaps = {
                ['q'] = 'actions.close',
                ['l'] = 'actions.select',
                ['<tab>'] = 'actions.preview',
                ['h'] = 'actions.toggle_hidden',
            },
            win_options = {
                signcolumn = 'no',
                foldcolumn = '0',
                cursorline = true,
            },
        }
    end,
}
