return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        style = "warm",
        styles = {
          comments = "italic",
          funcitons = "italic,bold",
        },
        highlights = {
          ["@tag"] = { fg = "$yellow" },
          ["@tag.attribute"] = { fg = "$red" },
          ["@constructor"] = { fg = "$blue" },
          ["@punctuation.bracket"] = { fg = "$red" },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
