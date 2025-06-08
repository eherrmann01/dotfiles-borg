local themes = {
    'nord',
    -- 'rose-pine',
    'zenbones',
    -- 'kanagawa',
    -- 'oxocarbon',
    -- 'everforest',
    'lunaperche',
    'slate',
}

local current = 1

local function apply_theme(index)
    local ok, err = pcall(function()
        vim.cmd.colorscheme(themes[index])
    end)
    if not ok then
        vim.notify('Failed to load theme: ' .. themes[index], vim.log.levels.ERROR)
    end
end

local function next_theme()
    current = current % #themes + 1
    apply_theme(current)
end

return {
    next = next_theme,
}
