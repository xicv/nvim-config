-- lua/custom/plugins/llm-claude.lua
-- Bridges the local Claude Code CLI (`claude` binary) to nvim via WebSocket MCP.
--
-- Workflow: Claude Code runs in a SEPARATE terminal window (kitty, tmux pane,
-- whatever) — NOT inside nvim. We set `provider = "none"` so nvim never spawns
-- its own Claude split, but the WebSocket server stays alive so an external
-- `claude` (started with `claude` or `/ide` from inside an existing session)
-- can connect and read selections / current file / accept-or-deny diffs.
--
-- The pay-off: no copy-paste between nvim and Claude. ,ab adds the current
-- buffer as an @-ref, ,as (visual) sends a selection, diffs land back in
-- nvim where ,aa / ,ad accept-or-deny them.
return {
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    opts = {
      terminal = {
        provider = 'none', -- no in-nvim terminal; external `claude` connects via MCP
      },
      track_selection = true,
      focus_after_send = false,
      diff_opts = {
        layout = 'vertical',
        keep_terminal_focus = false,
      },
    },
    keys = {
      { '<leader>a', nil, desc = 'AI / Claude' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Claude: add current [B]uffer as @-ref' },
      {
        '<leader>az',
        function()
          local file = vim.fn.expand '%:p'
          if file == '' then
            Snacks.notify.warn 'No file in current buffer'
            return
          end
          local dir = vim.fn.expand '%:p:h'
          local root = vim.fn.systemlist({ 'git', '-C', dir, 'rev-parse', '--show-toplevel' })[1]
          local rel = (vim.v.shell_error == 0 and root and root ~= '') and file:sub(#root + 2) or file
          local atref = '@' .. rel
          -- Push via MCP if Claude is connected, AND mirror to clipboard for paste-into-terminal fallback.
          pcall(vim.cmd, 'ClaudeCodeAdd ' .. vim.fn.fnameescape(file))
          vim.fn.setreg('+', atref)
          vim.fn.setreg('"', atref)
          Snacks.notify('Sent + copied: ' .. atref, { title = 'Claude' })
        end,
        desc = 'Claude: send path as @-ref (+ copy to clipboard)',
      },
      -- ,as is mode-aware:
      --   visual mode  → send the highlighted text to Claude.
      --   normal mode  → send the current file path as @-ref (same as ,ab).
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', desc = 'Claude: [S]end selection', mode = 'v' },
      { '<leader>as', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Claude: [S]end current file', mode = 'n' },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Claude: [A]ccept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Claude: [D]eny diff' },
      { '<leader>aS', '<cmd>ClaudeCodeStatus<cr>', desc = 'Claude: [S]tatus (WebSocket lock file)' },
    },
  },
}
