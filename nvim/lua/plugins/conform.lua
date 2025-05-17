return { -- Autoformat
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = true,
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { { "prettierd", "prettier" } },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      json = { "prettier" },
      graphql = { "prettier" },
      -- markdown = { "prettier" },
      ruby = { "rubyfmt" },
      rust = { "rustfmt" },
      sql = { "sqlfmt" },
      sh = { "shfmt" },
      go = { "gofmt" },
      zig = { "zigfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  },
}
