return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- 'nvim-treesitter/nvim-treesitter-context',
  },
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "java",
        "markdown_inline",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "yaml",
        "svelte",
        "prisma",
        "vim",
        "graphql",
        "cpp",
        "gitignore",
        "c_sharp",
        "cmake",
        "php",
        "ruby",
        "rust",
        "scheme",
        "racket",
        "dockerfile",
        "sql",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true, disable = { "latex" } },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>is",
          node_incremental = "<leader>ni",
          scope_incremental = "<leader>si",
          node_decremental = "<leader>nd",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },

          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "v", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },

          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]o"] = { query = { "@loop.inner", "@loop.outer" } },
            ["]s"] = { query = "@scope", query_group = "locals", desc = "next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@classouter",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "class.outer",
          },
        },
      },
    })
  end,
}
