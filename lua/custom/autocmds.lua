-- [[ Autocommands ]]
-- Yank highlight, cursor-position restore, and the LSP-attach hook that
-- wires up per-buffer LSP keymaps.
-- See `:help lua-guide-autocommands`.

-- Highlight yanked text briefly.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Restore cursor to last position when re-opening a file.
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position',
  group = vim.api.nvim_create_augroup('restore-cursor', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- LSP-attach: per-buffer keymaps + document-highlight + inlay-hint toggle.
-- All `,c*` and unprefixed `g*` LSP keys live here because they only make
-- sense in buffers that actually have an LSP client.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, fn, desc, mode)
      vim.keymap.set(mode or 'n', keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump-to-* keys (no leader, vim-classic).
    map('gd', function()
      Snacks.picker.lsp_definitions()
    end, '[G]oto [D]efinition')
    map('gr', function()
      Snacks.picker.lsp_references()
    end, '[G]oto [R]eferences')
    map('gI', function()
      Snacks.picker.lsp_implementations()
    end, '[G]oto [I]mplementation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('K', vim.lsp.buf.hover, 'Hover documentation')

    -- ,c* group = code actions.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
    map('<leader>cf', function()
      require('conform').format { async = true, lsp_fallback = true }
    end, '[C]ode [F]ormat buffer')
    map('<leader>ct', function()
      Snacks.picker.lsp_type_definitions()
    end, '[C]ode [T]ype definition')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Cursor-rested document highlight (clears on move).
    if client and client.server_capabilities.documentHighlightProvider then
      local hl = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = hl,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = hl,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(ev2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = ev2.buf }
        end,
      })
    end

    -- Toggle inlay hints (if the server supports them).
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map('<leader>ch', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[C]ode toggle inlay [H]ints')
    end
  end,
})
