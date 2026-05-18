-- [[ Keymaps ]]
-- Leader = ','  (set in custom/options.lua)
--
-- Design: 10 top-level bindings for the actions used hundreds of times a day.
-- Everything else lives under an UPPERCASE prefix (,S ,T ,G ,R) or a lowercase
-- group that doesn't collide with a top-level action (,a ,c ,x ,h).

local map = vim.keymap.set

-- ─────────────────────────────────────────────────────────────────────────────
-- Top-level (immediate) — the daily-driver keys.
-- ─────────────────────────────────────────────────────────────────────────────

-- ,g — live grep. Switched off fff.live_grep() in May 2026 because fff 0.8.1
-- has a Blob/String bug in grep_renderer.lua. Snacks.picker.grep is equally
-- live-as-you-type and uses ripgrep directly.
map('n', '<leader>g', function()
  Snacks.picker.grep()
end, { desc = '[G]rep live (snacks/rg)' })

map('n', '<leader>f', function()
  require('fff').find_files()
end, { desc = '[F]ind files (fff)' })

-- ,e — toggle the snacks.explorer sidebar (close if already open).
map('n', '<leader>e', function()
  local pickers = Snacks.picker.get { source = 'explorer' }
  if pickers and #pickers > 0 then
    pickers[1]:close()
  else
    Snacks.explorer()
  end
end, { desc = '[E]xplorer toggle (left sidebar)' })

map('n', '<leader>b', '<cmd>GitBlameToggle<CR>', { desc = 'Git [B]lame line toggle' })

map('n', '<leader>s', '<cmd>w<CR>', { desc = '[S]ave file' })

map('n', '<leader>v', '<cmd>vsplit<CR>', { desc = '[V]ertical split' })

map('n', '<leader>w', '<C-w>w', { desc = 'Cycle [W]indow' })

-- ,z — copy current file path from git root (fallback: full path).
-- Optimized for "paste into Claude Code in the next terminal" — the path it
-- copies is exactly what `@<path>` references in Claude expect.
map('n', '<leader>z', function()
  local file = vim.fn.expand '%:p'
  if file == '' then
    Snacks.notify.warn 'No file in current buffer'
    return
  end
  local file_dir = vim.fn.expand '%:p:h'
  local git_root = vim.fn.systemlist({ 'git', '-C', file_dir, 'rev-parse', '--show-toplevel' })[1]
  local out
  if vim.v.shell_error == 0 and git_root and git_root ~= '' then
    out = file:sub(#git_root + 2) -- strip "<root>/"
  else
    out = file
  end
  vim.fn.setreg('+', out)
  vim.fn.setreg('"', out)
  Snacks.notify('Copied: ' .. out, { title = 'Path' })
end, { desc = '[Z] Copy path (git-relative)' })

map('n', '<leader>t', function()
  Snacks.picker.lsp_symbols()
end, { desc = '[T] Symbols in file' })

map('n', '<leader>r', function()
  Snacks.picker.recent()
end, { desc = '[R]ecent files' })

-- ,h — fuzzy-searchable list of every keymap (filterable by description).
-- Type "claude" to see all AI keys, "git" for git keys, etc.
map('n', '<leader>h', function()
  Snacks.picker.keymaps()
end, { desc = '[H]elp: keymap picker' })

-- ─────────────────────────────────────────────────────────────────────────────
-- Companion bindings for the AI workflow.
-- ─────────────────────────────────────────────────────────────────────────────

-- ,Z — copy "path:line" so you can paste a precise pointer into Claude:
--      e.g. "look at lua/foo.lua:42 — why does it ..."
map('n', '<leader>Z', function()
  local file = vim.fn.expand '%:p'
  if file == '' then
    Snacks.notify.warn 'No file in current buffer'
    return
  end
  local line = vim.fn.line '.'
  local file_dir = vim.fn.expand '%:p:h'
  local git_root = vim.fn.systemlist({ 'git', '-C', file_dir, 'rev-parse', '--show-toplevel' })[1]
  local rel
  if vim.v.shell_error == 0 and git_root and git_root ~= '' then
    rel = file:sub(#git_root + 2)
  else
    rel = file
  end
  local out = rel .. ':' .. line
  vim.fn.setreg('+', out)
  vim.fn.setreg('"', out)
  Snacks.notify('Copied: ' .. out, { title = 'Path:line' })
end, { desc = '[Z] Copy path:line (for Claude)' })

-- ,W — workspace symbols (LSP across whole project, live filter).
map('n', '<leader>W', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = '[W]orkspace symbols' })

-- ,/ — fuzzy lines in current buffer (different from ,g which is project-wide).
map('n', '<leader>/', function()
  Snacks.picker.lines()
end, { desc = 'Fuzzy lines in buffer' })

-- ,, — switch buffers
map('n', '<leader><leader>', function()
  Snacks.picker.buffers()
end, { desc = 'Switch buffers' })

-- Window management
map('n', '<leader>q', '<cmd>close<CR>', { desc = '[Q] Close window' })
map('n', '<leader>Q', '<cmd>qa<CR>', { desc = '[Q] Quit all' })

-- Buffer delete — moved off ,bd so ,b can be the immediate git-blame toggle.
map('n', '<S-q>', function()
  Snacks.bufdelete()
end, { desc = 'Buffer delete' })

-- ─────────────────────────────────────────────────────────────────────────────
-- Non-leader essentials.
-- ─────────────────────────────────────────────────────────────────────────────

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-n>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Diagnostic motion
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Terminal escape
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Window left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Window right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Window down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Window up' })

-- Buffer cycle
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })

-- Visual indent stays selected
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move lines (Alt+j/k)
map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better navigation
map('n', 'J', 'mzJ`z', { desc = 'Join lines, keep cursor' })
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Visual paste without yanking
map('v', 'p', '"_dP')

-- System clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
map({ 'n', 'v' }, '<leader>D', [["_d]], { desc = 'Delete without yanking' })

-- Path copies (kept alongside ,z): full path and project-relative.
map('n', '<leader>p', function()
  local filepath = vim.fn.expand '%:p'
  vim.fn.setreg('+', filepath)
  vim.fn.setreg('"', filepath)
  Snacks.notify('Copied: ' .. filepath, { title = 'Full path' })
end, { desc = 'Copy full [P]ath' })

map('n', '<leader>P', function()
  local filepath = vim.fn.expand '%'
  vim.fn.setreg('+', filepath)
  vim.fn.setreg('"', filepath)
  Snacks.notify('Copied: ' .. filepath, { title = 'Relative path' })
end, { desc = 'Copy relative [P]ath' })

-- Insert-mode helpers
map('i', 'jj', '<Esc>', { desc = 'Quick escape' })
map('i', '<C-f>', '<Right>')
map('i', '<C-b>', '<Left>')

-- Make file executable (kept on capital X so it doesn't collide with anything)
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Chmod +x current file' })

-- ─────────────────────────────────────────────────────────────────────────────
-- Search-subgroup (uppercase ,S) — rarely-used pickers stay reachable but
-- never compete with the ,s save binding.
-- ─────────────────────────────────────────────────────────────────────────────

map('n', '<leader>Sh', function()
  Snacks.picker.help()
end, { desc = '[S]earch [H]elp' })
map('n', '<leader>Sk', function()
  Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>Sn', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim config files' })
map('n', '<leader>SS', function()
  Snacks.picker.pickers()
end, { desc = '[S]earch picker menu' })
map('n', '<leader>SR', function()
  Snacks.picker.resume()
end, { desc = '[S]earch [R]esume last picker' })
