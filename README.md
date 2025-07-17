# Neovim Configuration

A modern, feature-rich Neovim configuration based on Kickstart.nvim with custom enhancements and VSCode-like key mappings.

## Features

### Core Vim Features
- ✅ **System Clipboard Integration**: Seamless copy/paste with system clipboard
- ✅ **Search Highlighting**: Persistent search highlights with incremental search
- ✅ **Highlighted Yank**: Visual feedback when yanking text
- ✅ **Surround**: Advanced text object manipulation with mini.surround
- ✅ **EasyMotion**: Quick navigation with hop.nvim (modern alternative)
- ✅ **Bookmarks**: Persistent bookmarks with vim-bookmarks
- ✅ **Git Integration**: Git blame, signs, and advanced git operations

### Language Support
- **Go**: Full LSP support with gopls, formatting, and go.nvim
- **TypeScript/JavaScript**: Complete web development setup
- **Python**: LSP, formatting with black and isort
- **Rust**: Full rust-analyzer integration
- **C/C++**: clangd support with formatting
- **Lua**: Optimized for Neovim configuration
- **Web Technologies**: HTML, CSS, JSON, YAML support
- **Shell Scripting**: Bash/shell script support

### Modern Development Tools
- **LSP Integration**: Multiple language servers with Mason
- **Auto-completion**: Advanced completion with nvim-cmp
- **Fuzzy Finding**: Telescope for files, symbols, and live grep
- **Git Integration**: Gitsigns, fugitive, and git-blame
- **Terminal Management**: Integrated terminal with toggleterm
- **File Explorer**: Modern file tree with nvim-tree
- **Code Formatting**: Conform.nvim with multiple formatters
- **Diagnostics**: Trouble.nvim for better error handling
- **Session Management**: Auto-session for project workflows

### AI Integration
- **GitHub Copilot**: Code completion and suggestions
- **Copilot Chat**: AI-powered code explanations and fixes
- **Claude Code**: Advanced AI assistance integration

## Installation

### Prerequisites
- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Node.js (for some LSP servers)
- Python 3 (for some plugins)

### Quick Setup
1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone git@github.com:xicv/nvim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   The configuration will automatically install all plugins and language servers on first run.

### Manual Installation Steps
If you prefer to set up manually:

1. Install required tools:
   ```bash
   # macOS
   brew install neovim node python3 git
   
   # Ubuntu/Debian
   sudo apt install neovim nodejs npm python3 git
   ```

2. Clone and start Neovim - plugins will auto-install via lazy.nvim

## Key Mappings

### Leader Key
The leader key is set to `,` (comma).

### Insert Mode
| Key | Action |
|-----|--------|
| `jj` | Quick escape to normal mode |

### Normal Mode
| Key | Action |
|-----|--------|
| `<C-n>` | Clear search highlights |
| `<Space>` | Start search (/) |
| `K` | Insert line break |

### Leader Key Mappings
| Key | Action |
|-----|--------|
| `,a` | Toggle bookmarks |
| `,A` | List all bookmarks |
| `,s` | Save file |
| `,t` | Go to symbol/type |
| `,f` | Format document |
| `,r` | Open recent files |
| `,g` | Find in files (grep) |
| `,c` | Toggle terminal |
| `,e` | Toggle file explorer |
| `,d` | Toggle Claude Code/Copilot Chat |
| `,x` | GitHub Copilot fix suggestion |
| `,q` | GitHub Copilot explain code |
| `,b` | Toggle git blame |
| `,w` | Switch between windows (cycling) |

### EasyMotion (Hop) Mappings
| Key | Action |
|-----|--------|
| `<leader><leader>w` | Hop to word |
| `<leader><leader>l` | Hop to line |
| `<leader><leader>c` | Hop to character |
| `<leader><leader>/` | Hop to pattern |

### Terminal Mappings
| Key | Action |
|-----|--------|
| `,tf` | Toggle floating terminal |
| `,th` | Toggle horizontal terminal |
| `,tv` | Toggle vertical terminal |
| `,tg` | Toggle lazygit |
| `,tn` | Toggle Node.js terminal |
| `,tp` | Toggle Python terminal |

### Harpoon (Quick File Navigation)
| Key | Action |
|-----|--------|
| `,ha` | Add file to harpoon |
| `,hh` | Toggle harpoon menu |
| `,1` to `,4` | Navigate to harpoon file 1-4 |

## Plugin List

### Core Plugins
- **lazy.nvim**: Plugin manager
- **nvim-treesitter**: Syntax highlighting and parsing
- **nvim-lspconfig**: LSP configuration
- **mason.nvim**: LSP/tool installer
- **nvim-cmp**: Autocompletion
- **telescope.nvim**: Fuzzy finder

### Navigation & Movement
- **hop.nvim**: EasyMotion alternative
- **harpoon**: Quick file navigation
- **nvim-tree**: File explorer
- **which-key**: Key binding helper

### Git Integration
- **gitsigns.nvim**: Git signs in gutter
- **vim-fugitive**: Git commands
- **git-blame.nvim**: Git blame functionality

### Development Tools
- **conform.nvim**: Code formatting
- **trouble.nvim**: Diagnostics and quickfix
- **toggleterm.nvim**: Terminal management
- **vim-bookmarks**: Bookmark management
- **refactoring.nvim**: Code refactoring tools

### AI & Completion
- **copilot.vim**: GitHub Copilot
- **CopilotChat.nvim**: AI chat interface
- **claude-code.nvim**: Claude integration

### UI & Visual
- **mini.nvim**: Collection of useful mini-plugins
- **bufferline.nvim**: Buffer tabs
- **nvim-notify**: Enhanced notifications
- **tokyonight.nvim**: Color scheme

## Language Server Configuration

The configuration includes optimized settings for:

- **Go**: gopls with comprehensive analysis and hints
- **TypeScript/JavaScript**: ts_ls with full web development support
- **Python**: pyright for type checking
- **Rust**: rust-analyzer with clippy integration
- **C/C++**: clangd with formatting
- **Lua**: lua_ls optimized for Neovim
- **Web**: HTML, CSS, JSON language servers
- **Shell**: bashls for shell scripting

## Customization

### Adding New Plugins
Add plugins to the `lazy.setup()` call in `init.lua`:

```lua
require('lazy').setup({
  -- existing plugins...
  
  -- Your new plugin
  {
    'author/plugin-name',
    config = function()
      -- plugin configuration
    end,
  },
})
```

### Modifying Key Mappings
Key mappings are defined in the "Custom Key Mappings" section of `init.lua`. Add your own:

```lua
vim.keymap.set('n', '<leader>your_key', '<cmd>YourCommand<CR>', { desc = 'Your description' })
```

### Language Server Settings
Modify the `servers` table in the LSP configuration section to add or configure language servers.

## Troubleshooting

### Plugin Issues
- Run `:Lazy` to check plugin status
- Use `:Lazy update` to update plugins
- Use `:Lazy clean` to remove unused plugins

### LSP Issues
- Run `:Mason` to check installed servers
- Use `:LspInfo` to see attached language servers
- Check `:checkhealth` for general health

### Performance Issues
- Use `:Lazy profile` to check plugin load times
- Consider lazy-loading plugins with `event` or `ft` options

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This configuration is based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and includes custom enhancements.

## Support

For issues or questions:
- Check the [Neovim documentation](https://neovim.io/doc/)
- Visit the [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) repository
- Open an issue in this repository

---

*Happy coding with Neovim!* 🚀

