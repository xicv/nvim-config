-- lua/custom/plugins/init.lua
-- Aggregates every topic-specific plugin spec in this directory.
return {
  { import = 'custom.plugins.colorscheme' },
  { import = 'custom.plugins.snacks' },
  { import = 'custom.plugins.treesitter' },
  { import = 'custom.plugins.lsp' },
  { import = 'custom.plugins.completion' },
  { import = 'custom.plugins.formatter' },
  { import = 'custom.plugins.oil' },
  { import = 'custom.plugins.mini' },
  { import = 'custom.plugins.git' },
  { import = 'custom.plugins.diffview' },
  { import = 'custom.plugins.llm-claude' },
  { import = 'custom.plugins.llm-copilot' },
  { import = 'custom.plugins.nav' },
  { import = 'custom.plugins.editor' },
  { import = 'custom.plugins.ui' },
  { import = 'custom.plugins.misc' },
}
