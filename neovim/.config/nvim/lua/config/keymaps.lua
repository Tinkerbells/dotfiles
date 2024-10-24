-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-a>", "gg<S-v>G <CR>", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<Space>z", function()
  require("zen-mode").toggle({
    window = {
      width = 105,
    },
  })
end)
