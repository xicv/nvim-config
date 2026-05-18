return {
  -- Git signs in the gutter + hunk navigation.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { 'tpope/vim-fugitive', cmd = { 'Git', 'G' } },

  -- Per-line blame virtual text. Bound to ,b for instant toggle.
  {
    'f-person/git-blame.nvim',
    cmd = { 'GitBlameToggle', 'GitBlameEnable', 'GitBlameDisable' },
    keys = { { '<leader>b', '<cmd>GitBlameToggle<CR>', desc = 'Git [B]lame line toggle' } },
    config = function()
      require('gitblame').setup {
        enabled = false, -- toggle on demand
        date_format = '%r',
        message_template = ' <summary> • <date> • <author>',
        message_when_not_committed = ' Not yet committed',
        highlight_group = 'Question',
      }
    end,
  },
}
