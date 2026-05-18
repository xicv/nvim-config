-- lua/custom/plugins/editor.lua
-- Tiny editor-quality plugins. Heavy specialised motion / refactor / session
-- plugins were removed during the May-2026 minimal-rebuild pass.
return {
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
    opts = {},
  },

  -- Detect tabstop/shiftwidth from the file we just opened.
  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  -- Highlight TODO / FIXME / NOTE in comments.
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Better-looking quickfix / location list.
  { 'kevinhwang91/nvim-bqf', ft = 'qf', opts = {} },
}
