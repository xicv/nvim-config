-- lua/custom/plugins/snacks.lua
-- Snacks is the spine of this config: picker, explorer, notifier, lazygit,
-- dashboard, statuscolumn, indent, bigfile, scratch. One plugin, many modules.
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      input = { enabled = true },
      statuscolumn = { enabled = true },
      indent = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          -- Shortcuts shown on the launch screen. Single-char triggers.
          keys = {
            {
              icon = ' ',
              key = 'f',
              desc = 'Find File',
              action = ':lua Snacks.dashboard.pick("files")',
            },
            {
              icon = ' ',
              key = 'r',
              desc = 'Recent Files',
              action = ':lua Snacks.dashboard.pick("oldfiles")',
            },
            {
              icon = ' ',
              key = 'g',
              desc = 'Live Grep',
              action = ':lua Snacks.dashboard.pick("live_grep")',
            },
            { icon = ' ', key = 'e', desc = 'Explorer', action = ':lua Snacks.explorer()' },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ':lua Snacks.dashboard.pick("files", {cwd = vim.fn.stdpath("config")})',
            },
            { icon = '󰚩 ', key = 'a', desc = 'Claude Status', action = ':ClaudeCodeStatus' },
            {
              icon = '󰒲 ',
              key = 'L',
              desc = 'Lazy',
              action = ':Lazy',
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          -- Right pane: AI cheat sheet (open once you have a buffer)
          { pane = 2, icon = '󰚩 ', title = 'AI / Claude Code', padding = 1 },
          {
            pane = 2,
            text = {
              { '  ,ab  ', hl = 'SnacksDashboardKey' },
              { 'add current buffer as @-ref', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,as  ', hl = 'SnacksDashboardKey' },
              { 'send visual selection', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,aa  ', hl = 'SnacksDashboardKey' },
              { 'accept Claude diff', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,ad  ', hl = 'SnacksDashboardKey' },
              { 'deny Claude diff', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,az  ', hl = 'SnacksDashboardKey' },
              { 'send file path as @-ref (+ clipboard)', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,aS  ', hl = 'SnacksDashboardKey' },
              { 'show MCP server status', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,z   ', hl = 'SnacksDashboardKey' },
              { 'copy git-relative path', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,Z   ', hl = 'SnacksDashboardKey' },
              { 'copy path:line', hl = 'SnacksDashboardDesc' },
            },
          },
          { pane = 2, icon = ' ', title = 'Daily Bindings', padding = 1 },
          {
            pane = 2,
            text = {
              { '  ,h   ', hl = 'SnacksDashboardKey' },
              { 'help — fuzzy keymap picker', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,e   ', hl = 'SnacksDashboardKey' },
              { 'toggle explorer sidebar', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,f   ', hl = 'SnacksDashboardKey' },
              { 'find files', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,g   ', hl = 'SnacksDashboardKey' },
              { 'live grep across project', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,t   ', hl = 'SnacksDashboardKey' },
              { 'symbols in current file', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,r   ', hl = 'SnacksDashboardKey' },
              { 'recent files (frecency)', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,b   ', hl = 'SnacksDashboardKey' },
              { 'toggle git blame', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,s   ', hl = 'SnacksDashboardKey' },
              { 'save file', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,v   ', hl = 'SnacksDashboardKey' },
              { 'vertical split', hl = 'SnacksDashboardDesc' },
            },
          },
          {
            pane = 2,
            text = {
              { '  ,w   ', hl = 'SnacksDashboardKey' },
              { 'cycle window', hl = 'SnacksDashboardDesc' },
            },
          },
          { section = 'startup' },
        },
      },
      bufdelete = { enabled = true },
      lazygit = { enabled = true },
      scratch = { enabled = true },
      words = { enabled = true },

      -- File explorer (a picker in disguise) — opens as a left sidebar.
      explorer = {
        replace_netrw = true,
      },

      picker = {
        enabled = true,
        sources = {
          explorer = {
            -- Left sidebar, 30% width, no preview pane. Press ,e to toggle.
            layout = {
              preset = 'sidebar',
              preview = false,
              layout = { position = 'left', width = 0.30 },
            },
            -- Custom actions for the AI workflow.
            win = {
              list = {
                keys = {
                  -- ,as on a file inside the explorer adds it as an @-ref
                  -- to whatever Claude Code session is connected via MCP.
                  ['<leader>as'] = 'claude_send_file',
                  -- yz copies the highlighted file's path (git-relative).
                  ['yz'] = 'copy_git_relative_path',
                },
              },
            },
            actions = {
              claude_send_file = function(picker, item)
                if not item or not item.file then
                  return
                end
                local ok, _ = pcall(vim.cmd, 'ClaudeCodeAdd ' .. vim.fn.fnameescape(item.file))
                if ok then
                  Snacks.notify('Sent to Claude: ' .. vim.fn.fnamemodify(item.file, ':t'), { title = 'Claude' })
                end
              end,
              copy_git_relative_path = function(picker, item)
                if not item or not item.file then
                  return
                end
                local file = item.file
                local dir = vim.fn.fnamemodify(file, ':h')
                local root = vim.fn.systemlist({ 'git', '-C', dir, 'rev-parse', '--show-toplevel' })[1]
                local out
                if vim.v.shell_error == 0 and root and root ~= '' then
                  out = file:sub(#root + 2)
                else
                  out = file
                end
                vim.fn.setreg('+', out)
                vim.fn.setreg('"', out)
                Snacks.notify('Copied: ' .. out, { title = 'Path' })
              end,
            },
          },
        },
      },
    },
  },
}
