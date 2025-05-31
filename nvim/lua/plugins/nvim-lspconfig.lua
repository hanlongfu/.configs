return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- First, set up mason with explicit configuration
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Set up diagnostic signs
    local signs = {
      { name = "DiagnosticSignError", text = "✖" },
      { name = "DiagnosticSignWarn", text = "⚠" },
      { name = "DiagnosticSignInfo", text = "ℹ" },
      { name = "DiagnosticSignHint", text = "➤" },
    }

    -- Create a signs table for vim.diagnostic.config
    local sign_icons = {}
    for _, sign in ipairs(signs) do
      -- Extract the severity from the sign name (assuming names like "DiagnosticSignError")
      local severity_name = sign.name:match("DiagnosticSign(.+)")
      if severity_name then
        local severity = vim.diagnostic.severity[severity_name:upper()]
        if severity then
          sign_icons[severity] = sign.text
        end
      end
    end

    -- Configure diagnostics with the new API
    vim.diagnostic.config({
      signs = {
        text = sign_icons,
      },
    })

    -- Define capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- LSP server configurations
    local servers = {
      clangd = {},
      rust_analyzer = {},
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    -- Tool installation with correct package names
    local ensure_installed = {
      "clangd",
      "rust-analyzer", -- Corrected package name
      "lua-language-server",
      "stylua",
      "eslint-lsp",
      "prettier",
      "emmet-language-server",
      "json-lsp",
      "selene",
      "shellcheck",
      "shfmt",
      "js-debug-adapter",
      "css-lsp",
      "tailwindcss-language-server",
      "typescript-language-server",
      "zls",
      "solargraph",
      "pyright",
    }

    -- Set up mason-tool-installer
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = true,
    })

    -- Set up LSP servers manually
    local lspconfig = require("lspconfig")
    for server_name, server_opts in pairs(servers) do
      local opts = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, server_opts or {})

      lspconfig[server_name].setup(opts)
    end

    -- Set up LSP keymappings and other features
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- Helper function for keymappings
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- LSP keymappings
        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        map("gr", require("telescope.builtin").lsp_references, "Goto References")
        map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        map("<leader>td", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        -- Document highlight
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
