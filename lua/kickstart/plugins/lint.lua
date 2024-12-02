return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        {
          clojure = { 'clj-kondo' },
          dockerfile = { 'hadolint' },
          inko = { 'inko' },
          janet = { 'janet' },
          json = { 'jsonlint' },
          markdown = { 'vale' },
          rst = { 'vale' },
          ruby = { 'ruby' },
          terraform = { 'tflint' },
          text = { 'vale' },
          yaml = { 'yamllint' },
          yml = { 'yamllint' },
          python = { 'flake8' },
          fish = { 'fish' },
          go = { 'golangci-lint' },
          rust = { 'cargo' },
          c = { 'clang' },
          cpp = { 'clang' },
          lua = { 'luacheck' },
        },
      }

      lint.linters_by_ft = lint.linters_by_ft or {}

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
