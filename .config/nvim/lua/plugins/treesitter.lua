--  ______      _ _      _____     _    _                                               _____
-- |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
-- | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
-- |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
-- | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
-- |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

-- NeoVim treesitter configuration file, updated 12/08/2024
-- ~/.config/nvim/lua/plugins/treesitter.lua

-- Highlight, edit, and navigate code
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                -- List of parsers to ignore installing (or "all")
                ignore_install = { 'javascript' },
                highlight = {
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = { 'c', 'rust' },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
}

--    dependencies = {
--        'nvim-treesitter/nvim-treesitter-textobjects',
--    },
--    config = function()
--        require('nvim-treesitter.configs').setup {
--            -- Add languages to be installed here that you want installed for treesitter
--            ensure_installed = {
--                'lua',
--                'python',
--                'javascript',
--                'typescript',
--                'vimdoc',
--                'vim',
--                'regex',
--                'terraform',
--                'sql',
--                'dockerfile',
--                'toml',
--                'json',
--                'java',
--                'groovy',
--                'go',
--                'gitignore',
--                'graphql',
--                'yaml',
--                'make',
--                'cmake',
--                'markdown',
--                'markdown_inline',
--                'bash',
--                'tsx',
--                'css',
--                'html',
--            },
--
--            -- Autoinstall languages that are not installed
--            auto_install = true,
--
--            sync_install = false,
--            ignore_install = {},
--
--            highlight = { enable = true },
--            indent = { enable = true },
--            incremental_selection = {
--                enable = true,
--                keymaps = {
--                    init_selection = '<c-space>',
--                    node_incremental = '<c-space>',
--                    scope_incremental = '<c-s>',
--                    node_decremental = '<M-space>',
--                },
--            },
--            textobjects = {
--                select = {
--                    enable = true,
--                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--                    keymaps = {
--                        -- You can use the capture groups defined in textobjects.scm
--                        ['aa'] = '@parameter.outer',
--                        ['ia'] = '@parameter.inner',
--                        ['af'] = '@function.outer',
--                        ['if'] = '@function.inner',
--                        ['ac'] = '@class.outer',
--                        ['ic'] = '@class.inner',
--                    },
--                },
--                move = {
--                    enable = true,
--                    set_jumps = true, -- whether to set jumps in the jumplist
--                    goto_next_start = {
--                        [']m'] = '@function.outer',
--                        [']]'] = '@class.outer',
--                    },
--                    goto_next_end = {
--                        [']M'] = '@function.outer',
--                        [']['] = '@class.outer',
--                    },
--                    goto_previous_start = {
--                        ['[m'] = '@function.outer',
--                        ['[['] = '@class.outer',
--                    },
--                    goto_previous_end = {
--                        ['[M'] = '@function.outer',
--                        ['[]'] = '@class.outer',
--                    },
--                },
--                swap = {
--                    enable = true,
--                    swap_next = {
--                        ['<leader>a'] = '@parameter.inner',
--                    },
--                    swap_previous = {
--                        ['<leader>A'] = '@parameter.inner',
--                    },
--                },
--            },
--        }
--
--        -- Register additional file extensions
--        vim.filetype.add { extension = { tf = 'terraform' } }
--        vim.filetype.add { extension = { tfvars = 'terraform' } }
--        vim.filetype.add { extension = { pipeline = 'groovy' } }
--        vim.filetype.add { extension = { multibranch = 'groovy' } }
--    end,
--}
