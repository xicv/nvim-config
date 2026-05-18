-- lua/custom/plugins/lsp.lua
-- LSP setup using Neovim 0.12's native vim.lsp.config() + vim.lsp.enable() API.
-- Per-server overrides live in `lsp/<name>.lua` at the config root; nvim-lspconfig
-- supplies the default server definitions, which our overrides merge into.
-- The LspAttach autocmd (keymaps, highlights, inlay hints) lives in
-- `lua/custom/autocmds.lua`.

return {
  { 'folke/neodev.nvim', opts = {} },
  { 'williamboman/mason.nvim', config = true },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- LSP servers
          'lua_ls', 'rust_analyzer', 'gopls', 'ts_ls', 'pyright',
          'clangd', 'bashls', 'jsonls', 'yamlls', 'html', 'cssls', 'dockerls',
          -- Formatters (non-LSP, installed via mason)
          'stylua', 'prettier', 'black', 'isort', 'gofumpt', 'goimports',
          'shfmt', 'yamlfmt', 'clang-format',
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {}, -- mason-tool-installer handles this
      automatic_installation = false,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      -- Shared capabilities for all servers (blink.cmp adds completion capabilities).
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      vim.lsp.config('*', { capabilities = capabilities })

      -- Enable the servers whose config files live in `lsp/<name>.lua`
      -- (our overrides) and in nvim-lspconfig's own `lsp/<name>.lua` (defaults).
      vim.lsp.enable({
        'lua_ls', 'rust_analyzer', 'gopls', 'ts_ls', 'pyright',
        'clangd', 'bashls', 'jsonls', 'yamlls', 'html', 'cssls', 'dockerls',
      })
    end,
  },

  -- fidget.nvim — LSP progress only, general notifications go through snacks.notifier
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      progress = { display = { render_limit = 16 } },
      notification = { override_vim_notify = false },
    },
  },
}
