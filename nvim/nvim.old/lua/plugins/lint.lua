return {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePost' },
    opts = {
        linters_by_ft = {
            yaml = { 'yamllint', }
        },
    },
    config = function(_, opts)
        require('lint').linters_by_ft = opts.linters_by_ft
    end,
    init = function()
        vim.api.nvim_create_autocmd('BufWritePost', {
            desc = 'Lint on save',
            pattern = '*',
            group = vim.api.nvim_create_augroup('lint_on_save', { clear = true }),
            callback = function()
                require('lint').try_lint()
            end,
        })
    end,
}
