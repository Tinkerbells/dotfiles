-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {},
      ruff_lsp = {},
    },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- local format = require("lazyvim.plugins.lsp.format").format
    -- remap format keymap
    -- keys[#keys + 1] = { "<leader>fm", format, desc = "Format" }
    keys[#keys + 1] = { "<leader>cf", false }
    -- remap diagnostic keymaps
    keys[#keys + 1] = { "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>" }
    keys[#keys + 1] = { "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>" }
    keys[#keys + 1] = { "]d", false }
    keys[#keys + 1] = { "[d", false }
  end,
}
