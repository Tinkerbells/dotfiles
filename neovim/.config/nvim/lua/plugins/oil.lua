return {
  "stevearc/oil.nvim",
  opts = function(_, opts)
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
  end,
}
