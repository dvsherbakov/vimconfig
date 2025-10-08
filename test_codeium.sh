#!/bin/bash

echo "🔧 Testing Codeium Configuration..."
echo ""

# Check if Codeium binary exists
if command -v codeium >/dev/null 2>&1; then
    echo "✅ Codeium binary found"
else
    echo "⚠️  Codeium binary not found - this is normal for nvim plugin"
fi

# Check Neovim version
echo "📋 Neovim version:"
nvim --version | head -1

# Test Codeium plugin loading
echo ""
echo "🧪 Testing Codeium plugin loading..."
nvim --headless -c "lua print('Codeium plugin loaded: ' .. tostring(pcall(require, 'codeium')))" -c "qall" 2>/dev/null

echo ""
echo "🎯 Codeium Keybindings:"
echo "   • Tab - Accept suggestion (in insert mode)"
echo "   • Ctrl+→ - Accept word"
echo "   • Ctrl+↓ - Accept line"
echo "   • Ctrl+] - Clear suggestion"
echo "   • Alt+] - Next suggestion"
echo "   • Alt+[ - Previous suggestion"
echo ""
echo "📝 To test Codeium:"
echo "1. Open a code file in Neovim"
echo "2. Start typing code (e.g., 'function hello')"
echo "3. Wait for gray suggestion text to appear"
echo "4. Press Tab to accept the suggestion"
echo ""
echo "🔍 If Tab doesn't work, try:"
echo "   • :Codeium Enable"
echo "   • :Codeium Auth (if not authenticated)"
echo "   • Check if you see gray suggestion text first"
echo ""
echo "✨ Configuration files:"
echo "   • ~/.config/nvim/lua/ds/plugins/codeium.lua"
echo "   • ~/.codeium/config.json"