# Font and Ligature Setup for Neovim

## ✅ What I've Configured in Neovim:

1. **GUI Neovim clients** (Neovide, FVim, etc.) will use Cascadia Code font
2. **Terminal hint** set to prefer Cascadia Code

## 🔧 Terminal Configuration Required:

Since you're using terminal-based nvim, you need to configure your terminal emulator:

### For iTerm2 (macOS):
1. Open iTerm2 → Preferences → Profiles → Text
2. Set Font to "Cascadia Code" (size 12 recommended)
3. Enable "Use ligatures" checkbox
4. **Adjust line height**: In Advanced tab, search for "height" and set "Line height" to 1.2
5. Restart iTerm2

### For Terminal.app (macOS):
1. Terminal → Preferences → Profiles → Text
2. Click "Change" next to Font
3. Select "Cascadia Code" family
4. Size: 12pt recommended
5. **Line spacing**: You can't directly adjust line height in Terminal.app, but you can:
   - Use a slightly larger font size (13pt) for more spacing
   - Or switch to iTerm2 for better line height control

### For Alacritty:
Add to `~/.config/alacritty/alacritty.yml`:
```yaml
font:
  normal:
    family: "Cascadia Code"
    style: Regular
  bold:
    family: "Cascadia Code"
    style: Bold
  italic:
    family: "Cascadia Code"
    style: Italic
  size: 12
  offset:
    y: 2  # Increase line height
```

### For Kitty:
Add to `~/.config/kitty/kitty.conf`:
```
font_family Cascadia Code
font_size 12
disable_ligatures never
adjust_line_height 120%  # Increase line height by 20%
```

### For WezTerm:
Add to `~/.wezterm.lua`:
```lua
local wezterm = require 'wezterm'
return {
  font = wezterm.font("Cascadia Code"),
  font_size = 12,
  line_height = 1.2,  -- Increase line height
  harfbuzz_features = {"calt=1", "clig=1", "liga=1"},
}
```

## 📥 Install Cascadia Code Font:

### Option 1: Homebrew (Recommended)
```bash
brew install font-cascadia-code
```

### Option 2: Manual Download
1. Visit: https://github.com/microsoft/cascadia-code/releases
2. Download latest "CascadiaCode-*.zip"
3. Extract and install .ttf files

## 🎯 Ligature Examples:

Once configured, you'll see these ligatures in your code:
- `->` becomes →
- `=>` becomes ⇒
- `>=` becomes ≥
- `<=` becomes ≤
- `!=` becomes ≠
- `==` becomes ≡
- `&&` becomes ∧
- `||` becomes ∨

## 🧪 Test Your Setup:

Create a test file with:
```javascript
const arrow = (x) => x >= 10 && x <= 100;
if (value != null && result !== undefined) {
  console.log("Success!");
}
```

You should see beautiful ligatures if everything is configured correctly!

## 🔧 Troubleshooting:

1. **Font not found**: Make sure Cascadia Code is installed system-wide
2. **No ligatures**: Verify your terminal supports ligatures and it's enabled
3. **Wrong font in nvim**: Check that your terminal is using Cascadia Code
4. **GUI clients**: The nvim config will handle GUI clients automatically

Restart your terminal after making font changes!