# 🖥️ Neovim Terminal/Console Guide

## Current Built-in Options (Available Now)

### Basic Terminal Commands:
```vim
:terminal        " Open terminal in current window
:term            " Short version
:split | terminal " Open in horizontal split
:vsplit | terminal " Open in vertical split  
:tabnew | terminal " Open in new tab
```

### Navigation in Terminal:
- `Ctrl + \` then `Ctrl + n` - Exit terminal mode (go to normal mode)
- `i` or `a` - Enter terminal mode from normal mode
- Use your normal window navigation after exiting terminal mode

## 🚀 Enhanced Terminal (ToggleTerm Plugin - Install First)

After installing the ToggleTerm plugin I created for you, you'll have these keybindings:

### Main Terminal Controls:
| Key | Action | Description |
|-----|---------|-------------|
| `Ctrl + \` | **Quick toggle** | **Main terminal toggle shortcut** |
| `<leader>tt` | **Floating terminal** | **Toggle floating terminal window** |
| `<leader>tH` | Horizontal terminal | Terminal in bottom split |
| `<leader>tV` | Vertical terminal | Terminal in side split |

### Special Terminals:
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gg` | Lazygit | Git interface (if lazygit installed) |
| `<leader>tN` | Node REPL | JavaScript/Node.js console |
| `<leader>tP` | Python REPL | Python interpreter |

### Terminal Navigation:
| Key | Action | Description |
|-----|---------|-------------|
| `jk` or `Esc` | Exit terminal mode | Go to normal mode |
| `Ctrl + h/j/k/l` | Window navigation | Move between splits |

## 📋 Installation Steps:

1. **Restart Neovim** to load the ToggleTerm plugin
2. **Run `:Lazy sync`** to install the plugin
3. **Use the keybindings** above

## 🎯 Quick Start:

### Right Now (Built-in):
```vim
:split | terminal    " Open terminal in split
# Or
:vsplit | terminal   " Open terminal in vertical split
```

### After Installing ToggleTerm:
- Press `Ctrl + \` for instant floating terminal
- Press `<leader>tt` for floating terminal
- Press `<leader>tH` for horizontal terminal

## 🛠️ For Rust Development:

Since you're in a Rust project, you can run:
```bash
# In terminal
cargo build          # Build project  
cargo run            # Run project
cargo test           # Run tests
cargo check          # Quick compile check
```

## 💡 Pro Tips:

1. **Floating terminal** is great for quick commands
2. **Horizontal terminal** is perfect for running builds/tests
3. **Vertical terminal** works well for logs or monitoring
4. Use `jk` to quickly exit terminal mode (consistent with your insert mode mapping)