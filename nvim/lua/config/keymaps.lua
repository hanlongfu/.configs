vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- increment and decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")
--
-- map ctrl + a to select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- Remap keys for better Window management
vim.keymap.set("n", "<leader>vs", "<C-w>v", { desc = "[V]ertical [S]plit" }) -- split window vertically
vim.keymap.set("n", "<leader>hs", "<C-w>s", { desc = "[H]orizontal [S]plit" }) -- split window horizontally
vim.keymap.set("n", "<leader>es", "<C-w>=", { desc = "[E]qual [S]plit" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>cs", "<cmd>close<CR>", { desc = "[C]lose [S]plit" }) -- close current split window

-- Remap keys for better tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[t]ab [o]pen" }) -- open new tab
vim.keymap.set("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<s-tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- additional tab mgmt
vim.keymap.set("n", "<leader>bt", "<cmd>tab ba<CR>", { desc = "edit all [b]uffers as [t]abs" })
vim.keymap.set("n", "<leader>bv", "<cmd>vert ba<CR>", { desc = "edit all buffers as [v]ertical [w]indows" })
vim.keymap.set("n", "<leader>bh", "<cmd>hori ba<CR>", { desc = "edit all buffers as [h]orizontal [w]indows" })

-- remap keys for buffer movements (tab to control)
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "move to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<CR>", { desc = "move to prev buffer" })
vim.keymap.set("n", "]B", "<cmd>blast<CR>", { desc = "move to last buffer" })
vim.keymap.set("n", "[B", "<cmd>blast<CR>", { desc = "move to first buffer" })

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

-- quit without saving
vim.keymap.set("n", "X", "<cmd>q!<CR>", { desc = "quit without saving current buffer" })
vim.keymap.set("n", "XX", "<cmd>qa!<CR>", { desc = "force quite all open buffers without saving changes" }) -- equivalent to :q!

-- resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")
