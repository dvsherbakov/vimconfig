#!/bin/bash

# Setup script for DeepSeek API key with Codeium
echo "🚀 Setting up DeepSeek API key for Codeium..."
echo ""

# Check if DeepSeek API key is already set
if [ -z "$DEEPSEEK_API_KEY" ]; then
    echo "⚠️  DEEPSEEK_API_KEY environment variable not found."
    echo "Please set it in your shell profile (~/.zshrc or ~/.bashrc):"
    echo ""
    echo "export DEEPSEEK_API_KEY=\"your_actual_deepseek_api_key_here\""
    echo ""
    echo "After adding it to your shell profile, run:"
    echo "source ~/.zshrc  # or source ~/.bashrc"
    echo ""
    read -p "Enter your DeepSeek API key now (or press Enter to skip): " api_key
    
    if [ -n "$api_key" ]; then
        # Update the config.json with the API key
        if command -v jq >/dev/null 2>&1; then
            jq --arg key "$api_key" '.api_key = $key' ~/.codeium/config.json > ~/.codeium/config.json.tmp
            mv ~/.codeium/config.json.tmp ~/.codeium/config.json
            echo "✅ API key updated in ~/.codeium/config.json"
        else
            echo "📝 Please install jq to automatically update the config, or manually edit ~/.codeium/config.json"
            echo "Change the \"api_key\" field to: \"$api_key\""
        fi
    fi
else
    echo "✅ DEEPSEEK_API_KEY found in environment"
    # Update config.json with the environment variable
    if command -v jq >/dev/null 2>&1; then
        jq --arg key "$DEEPSEEK_API_KEY" '.api_key = $key' ~/.codeium/config.json > ~/.codeium/config.json.tmp
        mv ~/.codeium/config.json.tmp ~/.codeium/config.json
        echo "✅ Config updated with your API key"
    fi
fi

echo ""
echo "🔧 Configuration files created:"
echo "   • ~/.config/nvim/lua/ds/plugins/codeium.lua"
echo "   • ~/.codeium/config.json"
echo ""
echo "📋 Next steps:"
echo "1. Restart Neovim"
echo "2. Run :Lazy sync to install codeium.nvim"
echo "3. The plugin should automatically connect to DeepSeek"
echo ""
echo "🎯 Key bindings:"
echo "   • Tab - Accept suggestion"
echo "   • Ctrl+Right - Accept word"  
echo "   • Ctrl+Down - Accept line"
echo "   • Ctrl+] - Clear suggestion"
echo "   • Alt+] - Next suggestion"
echo "   • Alt+[ - Previous suggestion"
echo "   • <leader>cc - Open Codeium chat"
echo "   • <leader>ce - Enable Codeium"
echo "   • <leader>cd - Disable Codeium"
echo ""
echo "✨ Done! Happy coding with DeepSeek!"