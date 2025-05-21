vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- increment and decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Delete to blackhole register
vim.keymap.set("n", "\\d", '"_d', { desc = "Delete to blackhole" })
vim.keymap.set("v", "\\d", '"_d', { desc = "Delete selection to blackhole" })
vim.keymap.set("n", "\\D", '"_D', { desc = "Delete to end of line to blackhole" })

-- Change to blackhole register
vim.keymap.set("n", "\\c", '"_c', { desc = "Change to blackhole" })
vim.keymap.set("v", "\\c", '"_c', { desc = "Change selection to blackhole" })
vim.keymap.set("n", "\\C", '"_C', { desc = "Change to end of line to blackhole" })

-- cd to the directory containing the file in the buffer, both local and global flavors
vim.keymap.set("n", "<leader>cd", ":cd %:h<CR>", { silent = true })
vim.keymap.set("n", "<leader>lcd", ":lcd %:h<CR>", { silent = true })

-- Delete line to blackhole register
vim.keymap.set("n", "\\dd", '"_dd', { desc = "Delete line to blackhole" })

-- toggle show keypress on screen
vim.keymap.set("n", "<leader>ts", ":ShowkeysToggle<CR>", { desc = "Toggle Showkeys", silent = true })
-- toggle a countdown timer on screen
vim.keymap.set("n", "<leader>tt", ":TimerlyToggle<CR>", { desc = "Toggle Timerly", silent = true })

-- make vim search and substitution very magic (close to PCRE regex)
vim.keymap.set("n", "/", "/\\v", { noremap = true })
vim.keymap.set("n", "?", "?\\v", { noremap = true })
vim.keymap.set("v", "/", "/\\v", { noremap = true })
vim.keymap.set("v", "?", "?\\v", { noremap = true })
vim.keymap.set("c", "%s/", "%s/\\v", { noremap = true })
vim.keymap.set("c", "s/", "s/\\v", { noremap = true })
vim.keymap.set("c", "g/", "g/\\v", { noremap = true }) -- For global commands

-- Map x to delete to black hole register in normal and visual modes
vim.keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete character (black hole register)" })
vim.keymap.set("v", "x", '"_x', { noremap = true, desc = "Delete selection (black hole register)" })

-- in visual mode, move selected lines up and down using K,J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when joining lines, keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in place when jump half screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in place when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- <leader>p to paste over a text (so that the original paste buffer won't be overwritten)
vim.keymap.set("x", "<leader>p", '"_dP')

-- replace text under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- -- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- Remap keys for better Window management
vim.keymap.set("n", "<leader>vs", "<C-w>v", { desc = "[V]ertical [S]plit" }) -- split window vertically
vim.keymap.set("n", "<leader>hs", "<C-w>s", { desc = "[H]orizontal [S]plit" }) -- split window horizontally
vim.keymap.set("n", "<leader>es", "<C-w>=", { desc = "[E]qual [S]plit" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>cs", "<cmd>close<CR>", { desc = "[C]lose [S]plit" }) -- close current split window

-- Remap keys for better tab management
vim.keymap.set("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<s-tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab

-- Exit terminal mode in the '<cmd>Telescope terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "[M]arkdown [P]review" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "[M]arkdown Preview [S]top" })

-- resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- neogit
vim.keymap.set("n", "<leader>gh", "<cmd>Neogit kind=split<CR>", { desc = "Enter Neogit with horizontal split" })
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit kind=vsplit<CR>", { desc = "Enter Neogit with vertical split" })

-- diffview
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen<CR>", { desc = "Open Diff View" })
vim.keymap.set("n", "<leader>dF", "<cmd>DiffviewClose<CR>", { desc = "Open Diff View" })

-- delete line before and after an indented block (for various-textobjs plugin)
vim.keymap.set("n", "dsi", function()
  -- select outer indentation
  require("various-textobjs").indentation("outer", "outer")

  -- plugin only switches to visual mode when a textobj has been found
  local indentationFound = vim.fn.mode():find("V")
  if not indentationFound then
    return
  end

  -- dedent indentation
  vim.cmd.normal({ "<", bang = true })

  -- delete surrounding lines
  local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
  local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
  vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
  vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete Surrounding Indentation" })

-- debugging
vim.keymap.set("n", "<leader>co", function()
  require("dap").continue()
end, { desc = "continue debugging" })
vim.keymap.set("n", "<leader>sv", function()
  require("dap").step_over()
end, { desc = "step over" })
vim.keymap.set("n", "<leader>si", function()
  require("dap").step_into()
end, { desc = "step into" })
vim.keymap.set("n", "<leader>su", function()
  require("dap").step_out()
end, { desc = "step out" })
vim.keymap.set("n", "<Leader>tb", function()
  require("dap").toggle_breakpoint()
end, { desc = "toggle breakpoint" })
vim.keymap.set("n", "<Leader>db", function()
  require("dap").set_breakpoint()
end, { desc = "set breakpoint" })
vim.keymap.set("n", "<Leader>or", function()
  require("dap").repl.open()
end, { desc = "open repl" })
vim.keymap.set("n", "<Leader>rl", function()
  require("dap").run_last()
end, { desc = "last run" })
vim.keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "terminate debugging" })
