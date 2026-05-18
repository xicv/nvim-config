-- lua/custom/plugins/diffview.lua
-- Diffview keys live under the uppercase ,G* group so ,g stays free for live grep.
return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    keys = {
      { '<leader>Gd', '<cmd>DiffviewOpen<cr>', desc = 'Git: [D]iffview open' },
      { '<leader>GD', '<cmd>DiffviewClose<cr>', desc = 'Git: [D]iffview close' },
      { '<leader>Gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git: file [H]istory' },
      {
        '<leader>Gg',
        function()
          Snacks.lazygit.open()
        end,
        desc = 'Git: lazy[G]it',
      },
    },
    opts = {
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = 'diff3_mixed' } },
    },
  },
}
