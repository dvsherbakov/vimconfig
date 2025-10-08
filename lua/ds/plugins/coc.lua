return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    vim.keymap.set(
      "i",
      "<cr>",
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      opts
    )
  end,
}
