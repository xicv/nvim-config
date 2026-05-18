-- lua/custom/plugins/ui.lua
return {
  -- Buffer tabs along the top.
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        separator_style = 'slant',
        show_buffer_close_icons = false,
        show_close_icon = false,
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
      },
    },
  },

  -- Pop-up keymap hint table. The group labels below mirror the May-2026
  -- minimal layout (top-level ,g,f,e,b,s,v,w,z,t,r + a/c/x/h/S/G/F groups).
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      local wk = require 'which-key'
      wk.setup()
      wk.add {
        { '<leader>a', group = '[A]I / Claude Code' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>x', group = 'Trouble / e[X]ecutive' },
        { '<leader>H', group = '[H]arpoon' },
        { '<leader>S', group = '[S]earch (extras)' },
        { '<leader>G', group = '[G]it' },
        { '<leader>F', group = '[F]ff power modes' },
      }
    end,
  },

  -- Trouble panel for diagnostics, references, symbols.
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Trouble: buffer diagnostics' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Trouble: symbols panel' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'Trouble: LSP' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Trouble: loclist' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Trouble: qflist' },
      { '<leader>xe', vim.diagnostic.open_float, desc = 'Diagnostic float (current line)' },
    },
    opts = {},
  },
}
