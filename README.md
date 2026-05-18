# nvim-config

Minimal, terminal-first Neovim configured for **AI-driven development with Claude Code**. Lives next to a `claude` CLI in another terminal pane — the editor pushes selections, file paths, and diffs over a WebSocket MCP bridge without copy-paste.

37 plugins, ~10 daily-driver bindings, sub-second startup.

---

## Quickstart

One-liner on a fresh machine (macOS / Linux):

```bash
curl -fsSL https://raw.githubusercontent.com/xicv/nvim-config/main/install.sh | bash
```

What it installs:

- System: `neovim`, `git`, `ripgrep`, `fd`, `fzf`, `node` (via brew / apt / pacman / dnf).
- Repo → `~/.config/nvim/` (existing config gets backed up).
- All Neovim plugins via `lazy.nvim`.
- LSP servers + formatters via `Mason` (`stylua`, `prettier`, `lua_ls`, `gopls`, `pyright`, `ts_ls`, `rust_analyzer`, …).
- Treesitter parsers.

Manual install:

```bash
git clone https://github.com/xicv/nvim-config.git ~/.config/nvim
bash ~/.config/nvim/install.sh
```

Then launch `nvim` — first start re-runs `:Lazy sync` if anything is missing.

---

## Daily key bindings

Leader = `,`

```
,g  live grep across project        ,t  symbols in current file
,f  find files                      ,r  recent files (frecency)
,e  toggle explorer (left sidebar)  ,h  fuzzy keymap reference (this list!)
,b  toggle git blame on cursor line ,s  save file
,v  vertical split                  ,w  cycle window
,z  copy path (git-relative)        ,Z  copy path:line
,,  switch buffers                  ,/  fuzzy lines in current buffer
,q  close window                    ,Q  quit all
,W  workspace symbols (LSP)         <S-q>  buffer delete
```

LSP (active when an LSP attaches):

```
gd  go to definition       gr  go to references
gI  go to implementation   gD  go to declaration
K   hover documentation    ,ca code action
,cr rename                 ,cf format buffer
,ct type definition        ,ch toggle inlay hints
```

Press `,h` inside nvim for a fuzzy-searchable list of every key — type "claude", "git", "lsp" to filter.

---

## AI / Claude Code workflow

The MCP server runs **inside nvim** (no Claude split in the editor). Start `claude` in any other terminal, then `/ide` in that terminal to attach to nvim's WebSocket.

```
,ab  add current buffer as @-ref          ,aa  accept Claude's proposed diff
,as  send visual selection (in v-mode)    ,ad  deny Claude's diff
,az  send path as @-ref (+ clipboard)     ,aS  show MCP server status
```

Inside the explorer (`,e`):

```
<leader>as  add highlighted file to Claude context
yz          copy file path (git-relative) to clipboard
```

How it works: `coder/claudecode.nvim` runs a WebSocket server on a random port and writes a lock file to `~/.claude/ide/<port>.lock`. When `claude` runs `/ide`, it reads the lock file and connects. From then on:

- Selections sent via `,as` arrive in the Claude prompt instantly.
- Files added via `,ab` / `,az` become `@`-references Claude can read.
- When Claude proposes changes, nvim opens a native diff — `,aa` accepts, `,ad` rejects.

If `,as` does nothing, check `:ClaudeCodeStatus` — connected client count should be ≥ 1. Run `/ide` in claude again if it's 0.

---

## Architecture

```
~/.config/nvim/
├── init.lua                   thin bootstrap → custom/*
├── lua/custom/
│   ├── options.lua            vim options (leader, clipboard, …)
│   ├── keymaps.lua            all leader-prefixed top-level keys
│   ├── autocmds.lua           LSP-attach hook, yank highlight, cursor restore
│   └── plugins/               one file per topic, all imported by init.lua
│       ├── snacks.lua         picker / explorer / dashboard / notifier
│       ├── treesitter.lua
│       ├── lsp.lua            mason + lspconfig + neodev
│       ├── completion.lua     blink.cmp + copilot source
│       ├── llm-claude.lua     claudecode.nvim (MCP bridge)
│       ├── llm-copilot.lua    inline Copilot suggestions
│       ├── git.lua            gitsigns + fugitive + git-blame
│       ├── diffview.lua
│       ├── oil.lua            filesystem-as-buffer (-)
│       ├── nav.lua            fff.nvim + harpoon
│       ├── editor.lua         autopairs, Comment, sleuth, todo, bqf
│       ├── formatter.lua      conform.nvim
│       ├── mini.lua           mini.ai + mini.surround + mini.statusline
│       ├── ui.lua             bufferline + which-key + trouble
│       └── colorscheme.lua    tokyonight
└── lsp/                       per-server overrides (lua_ls, gopls, …)
```

Every plugin lives in one small focused file. Adding a new one: drop a new `.lua` under `lua/custom/plugins/`, add it to `lua/custom/plugins/init.lua`, restart.

---

## Customization

Change leader: edit `lua/custom/options.lua`, line `vim.g.mapleader = ','`.

Add a plugin: create `lua/custom/plugins/my-plugin.lua` returning a lazy.nvim spec, then `{ import = 'custom.plugins.my-plugin' }` in `init.lua`.

Change colorscheme: edit `lua/custom/plugins/colorscheme.lua`.

Disable Copilot: comment out `{ import = 'custom.plugins.llm-copilot' }` in `lua/custom/plugins/init.lua`.

Disable AI bridge: same, but `llm-claude`.

---

## Requirements

- Neovim ≥ 0.10 (0.12+ recommended for native `vim.lsp.config`)
- Git, ripgrep, fd, fzf, Node.js (for some LSPs)
- A Nerd Font in your terminal (for icons). Cascadia Code or JetBrains Mono Nerd.
- macOS, Linux, or WSL.

---

## License

MIT — see `LICENSE`.
