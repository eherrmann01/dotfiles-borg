return {
    {
        'zenbones-theme/zenbones.nvim',
        dependencies = 'rktjmp/lush.nvim',
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        config = function()
            vim.g.zenbones_darken_comments = 45
            vim.cmd.colorscheme 'zenbones'
        end,
    },
}
