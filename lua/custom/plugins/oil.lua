-- lua/custom/plugins/oil.lua
-- Filesystem-as-a-buffer for ad-hoc rename / move / delete operations.
-- ,e is owned by snacks.explorer (sidebar). Oil opens via `-` (parent dir)
-- and `,o` (an alias when you want to think "oil" specifically).
return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false, -- snacks.explorer owns netrw replacement
      view_options = { show_hidden = true },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['q'] = 'actions.close',
      },
    },
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    cmd = { 'Oil' },
    keys = {
      { '<leader>o', '<cmd>Oil<cr>', desc = '[O]il: open parent directory' },
      { '-', '<cmd>Oil<cr>', desc = 'Oil: open parent directory' },
    },
  },
}
