-- Modern LSP configuration using vim.lsp.config (Neovim 0.11+)
local function setup_lsp()
  -- Import cmp-nvim-lsp for capabilities
  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = cmp_nvim_lsp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

  -- Set up LSP keybindings
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }

      -- LSP keybindings
      vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP references" }))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))
      vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "See available code actions" }))
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Smart rename" }))
      vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show documentation for what is under cursor" }))
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
    end,
  })

  -- Configure diagnostics with modern API
  vim.diagnostic.config({
    -- Show signs in the sign column
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰠠 ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    -- Virtual text configuration
    virtual_text = {
      enabled = true,
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    -- Floating window configuration
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
    -- Update diagnostics in insert mode
    update_in_insert = false,
    -- Severity sorting
    severity_sort = true,
  })

  -- Configure rust-analyzer using vim.lsp.config
  vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
    single_file_support = true,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = true,
        check = {
          command = "clippy",
        },
        diagnostics = {
          enable = true,
        },
      },
    },
  }

  -- Configure other LSP servers
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    },
    ts_ls = {},
    html = {},
    cssls = {},
    tailwindcss = {},
    emmet_ls = {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    },
    svelte = {},
    graphql = {
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    },
    prismals = {},
  }

  -- Setup other servers using vim.lsp.config
  for server_name, server_config in pairs(servers) do
    local config = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, server_config)
    
    vim.lsp.config[server_name] = config
  end
end

return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "antosha417/nvim-lsp-file-operations", 
    config = true,
    lazy = true,
  },
  {
    "folke/neodev.nvim", 
    opts = {},
    lazy = true,
  },
  {
    -- We still need this for the setup function
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = setup_lsp,
  },
}

