return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    table.insert(opts.sources, nls.builtins.formatting.prettierd)
    table.insert(opts.sources, nls.builtins.formatting.black)
    table.insert(opts.sources, nls.builtins.formatting.shfmt)
    table.insert(opts.sources, nls.builtins.formatting.stylua)
    table.insert(opts.sources, nls.builtins.diagnostics.shellcheck)
  end,
}
