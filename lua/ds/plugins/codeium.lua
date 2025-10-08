return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "BufEnter",
  config = function()
    require("codeium").setup({
      -- Enable all features
      enable_chat = true,
      -- Virtual text configuration for inline suggestions
      virtual_text = {
        enabled = true,
        manual = false,
        idle_delay = 75,
        virtual_text_priority = 65535,
        map_keys = true,
        key_bindings = {
          accept = "<Tab>",
          accept_word = "<C-Right>",
          accept_line = "<C-Down>", 
          clear = "<C-]>",
          next = "<M-]>",
          prev = "<M-[>",
        }
      },
      -- Tools configuration
      tools = {
        curl = "curl",
        gzip = "gzip",
        uname = "uname",
        uuidgen = "uuidgen",
      },
    })
    
    -- Optional additional keymaps for management
    vim.keymap.set("n", "<leader>cc", "<cmd>Codeium Chat<cr>", { desc = "Open Codeium Chat" })
    vim.keymap.set("n", "<leader>ce", "<cmd>Codeium Enable<cr>", { desc = "Enable Codeium" })
    vim.keymap.set("n", "<leader>cd", "<cmd>Codeium Disable<cr>", { desc = "Disable Codeium" })
  end,
}

