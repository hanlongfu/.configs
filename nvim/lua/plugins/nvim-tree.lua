return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
    vim.cmd([[ highlight SignColumn guibg=NONE]])

    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      -- Buffer-specific keymaps (only active in nvim-tree buffer)
      local opts = { buffer = bufnr, noremap = true, silent = true }

      vim.keymap.set("n", "<leader>m", function()
        api.tree.marks.bulk.move()
      end, vim.tbl_extend("force", opts, { desc = "Move bookmarked file" }))

      vim.keymap.set("n", "<leader>c", function()
        api.tree.change_root_to_node()
      end, vim.tbl_extend("force", opts, { desc = "Change dir to current dir" }))

      vim.keymap.set("n", "<leader>p", function()
        api.tree.change_root_to_parent()
      end, vim.tbl_extend("force", opts, { desc = "Change dir to parent directory" }))
    end
    -- configure nvim-tree
    nvimtree.setup({
      on_attach = on_attach,
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {},
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
