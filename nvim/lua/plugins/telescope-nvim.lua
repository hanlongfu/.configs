-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- This adds navigation mappings in the insert mode
      defaults = {
        mappings = {
          i = {
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<c-j>"] = require("telescope.actions").move_selection_next,
            ["<c-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
          },
        },
      },
      -- pickers = {}
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable telescope extensions, if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- keymappings
    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search Current Word" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
    vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Search Marks" })
    vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Search Quickfix list" })
    vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Search Jump list" })
    vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "Search Registers" })
    vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "Search Command History" })
    vim.keymap.set("n", "<leader>qh", builtin.search_history, { desc = "Search Search History" })
    vim.keymap.set("n", "<leader>sp", builtin.man_pages, { desc = "Search manpage entries" })
    vim.keymap.set("n", "<leader>se", builtin.resume, { desc = "Search Resume" })
    vim.keymap.set("n", "<leader>sl", builtin.oldfiles, { desc = 'Search Old Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search Existing Buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>sc", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "Fuzzily Search in Current buffer" })

    -- Also possible to pass additional configuration options
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>so", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "Search in Open Files" })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Search Neovim Files" })
  end,
}
