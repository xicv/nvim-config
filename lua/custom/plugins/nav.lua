-- lua/custom/plugins/nav.lua
-- Navigation = fff.nvim (find files / live grep) + harpoon (quick file marks).
-- Aerial was removed in the May-2026 cleanup; Snacks.picker.lsp_symbols (,t)
-- covers in-file symbol navigation.
return {
  -- Harpoon — pin 1–4 files for instant jump.
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>Ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = '[H]arpoon: [A]dd file',
      },
      {
        '<leader>Hh',
        function()
          local h = require 'harpoon'
          h.ui:toggle_quick_menu(h:list())
        end,
        desc = '[H]arpoon: menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = '[H]arpoon: file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = '[H]arpoon: file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = '[H]arpoon: file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = '[H]arpoon: file 4',
      },
      {
        '<leader>Hp',
        function()
          require('harpoon'):list():prev()
        end,
        desc = '[H]arpoon: prev',
      },
      {
        '<leader>Hn',
        function()
          require('harpoon'):list():next()
        end,
        desc = '[H]arpoon: next',
      },
    },
    config = function()
      require('harpoon'):setup()
    end,
  },

  -- fff.nvim — Rust-backed fuzzy file finder.
  -- ,f (in keymaps.lua) → require('fff').find_files()
  -- Grep keys live on Snacks.picker.grep because fff 0.8.1 has a Blob/String
  -- bug in grep_renderer.lua; ripgrep through snacks is fine.
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    opts = {},
    keys = {
      {
        '<leader>Fc',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'grep word under [C]ursor',
      },
      {
        '<leader>Fb',
        function()
          Snacks.picker.grep { buffers = true }
        end,
        desc = 'grep in open [B]uffers',
      },
    },
  },
}
