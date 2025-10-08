return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],  -- Ctrl+\ to toggle terminal
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
      shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 120,
        height = 30,
        winblend = 3,
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    })

    -- Set keymaps for terminal management
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Toggle floating terminal (main terminal shortcut)
    keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", vim.tbl_extend("force", opts, { desc = "Toggle floating terminal" }))
    
    -- Toggle horizontal terminal  
    keymap("n", "<leader>tH", "<cmd>ToggleTerm direction=horizontal<cr>", vim.tbl_extend("force", opts, { desc = "Toggle horizontal terminal" }))
    
    -- Toggle vertical terminal
    keymap("n", "<leader>tV", "<cmd>ToggleTerm direction=vertical<cr>", vim.tbl_extend("force", opts, { desc = "Toggle vertical terminal" }))


    -- Terminal mode keymaps
    keymap("t", "<esc>", [[<C-\><C-n>]], opts)
    keymap("t", "jk", [[<C-\><C-n>]], opts)
    keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

    -- Custom terminal functions
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit integration
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Lazygit" }))

    -- Node REPL
    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    keymap("n", "<leader>tN", "<cmd>lua _NODE_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Node REPL" }))

    -- Python REPL
    local python = Terminal:new({ cmd = "python3", hidden = true })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    keymap("n", "<leader>tP", "<cmd>lua _PYTHON_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Python REPL" }))
  end,
}