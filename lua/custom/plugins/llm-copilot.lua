-- lua/custom/plugins/llm-copilot.lua
-- Copilot via the Lua client. Ghost-text suggestion and panel are DISABLED here
-- because blink.cmp owns the completion UI via the blink-copilot source.
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'fang2hou/blink-copilot',
    dependencies = { 'zbirenbaum/copilot.lua' },
    lazy = true,
  },
}
