-- lua/custom/plugins/completion.lua
-- Completion engine: blink.cmp v1
-- Sources in this phase: lsp, path, snippets (LuaSnip), buffer.
-- Copilot source will be added in Phase 5.
return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = (function()
      if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
        return nil
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = {},
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    -- prebuilt binary is downloaded automatically via `version = '1.*'`.
    -- uncomment the next line only if prebuilt download fails:
    -- build = 'cargo build --release',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'fang2hou/blink-copilot',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
