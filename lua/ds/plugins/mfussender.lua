return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }
    vim.keymap.set({ "n", "v" }, "<leader>lp", function()
      require("lint").try_lint()
    end, { desc = "Trigger linting for current file" })

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertEnter", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
