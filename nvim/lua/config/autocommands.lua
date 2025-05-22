-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- preview markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { buffer = true, desc = "Markdown Preview" })
    vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { buffer = true, desc = "Stop Markdown Preview" })
    vim.keymap.set(
      "n",
      "<leader>mt",
      "<Plug>MarkdownPreviewToggle",
      { buffer = true, desc = "Toggle Markdown Preview" }
    )
  end,
})

-- preview image using imge_preview plugin (<leader>p)
-- preview pdf using pdf Expert <leader>o
-- preview other file types using system default applicationa <leader>o
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    -- Preview images
    vim.keymap.set("n", "<leader>p", function()
      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      if node and node.type == "file" then
        require("image_preview").PreviewImage(node.absolute_path)
      end
    end, { buffer = true, desc = "Preview Image" })

    -- Open PDFs in PDF Expert (or other files in appropriate apps)
    vim.keymap.set("n", "<leader>o", function()
      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      if node and node.type == "file" then
        local file_path = node.absolute_path
        local file_ext = file_path:match("%.([^%.]+)$")
        local filename = vim.fn.fnamemodify(file_path, ":t")

        if file_ext and file_ext:lower() == "pdf" then
          vim.fn.system(string.format("open -a 'PDF Expert' '%s'", file_path))
          vim.notify("Opening " .. filename .. " in PDF Expert")
        else
          -- For non-PDF files, use system default
          vim.fn.system(string.format("open '%s'", file_path))
          vim.notify("Opening " .. filename .. " with system default")
        end
      end
    end, { buffer = true, desc = "Open file externally" })

    -- Close image preview
    vim.keymap.set("n", "<leader>q", function()
      require("image_preview").ClosePreview()
    end, { buffer = true, desc = "Close Image Preview" })
  end,
})
