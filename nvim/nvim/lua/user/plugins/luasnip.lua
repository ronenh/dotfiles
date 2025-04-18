return {
    'L3MON4D3/LuaSnip',
    lazy = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    keys = {
        { '<C-h>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' } },
        { '<C-l>', function() require('luasnip').jump(1) end,  mode = { 'i', 's' } },
    },
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}
