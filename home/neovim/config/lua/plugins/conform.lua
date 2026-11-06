return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        svelte = { "prettierd", "eslint_d" },
        astro = { "prettierd", "eslint_d" },
        vue = { "prettierd", "eslint_d" },
        javascript = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        graphql = { 'prettierd', 'prettier', stop_after_first = true },
        java = { 'google-java-format' },
        kotlin = { 'ktlint' },
        ruby = { 'standardrb' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        erb = { 'htmlbeautifier' },
        html = { 'htmlbeautifier' },
        bash = { 'beautysh' },
        proto = { 'buf' },
        rust = { 'rustfmt' },
        yaml = { 'yamlfix' },
        toml = { 'taplo' },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        sh = { 'shellcheck' },
        go = { 'gofmt', 'goimports' },
        xml = { 'xmllint' },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
