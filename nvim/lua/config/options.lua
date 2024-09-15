--[]]
--
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- record the last # of commands
vim.opt.history = 200

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- include '-' as part of 'word'
vim.opt.iskeyword:append({ "@", "48-57", "_", "192-255", "-" })

vim.opt.termguicolors = true

-- enable a navigable list of suggestions in vim command
vim.opt.wildmenu = true
vim.opt.wildmode = "full"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Enable break indent
vim.opt.breakindent = true

-- do not show breaks if they're not there
vim.opt.wrap = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
-- timeoutlen can't be too short, otherwise leader key will not work
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = " ", trail = "·", nbsp = "␣" }

-- Get rid of tilde in a blank vim window
vim.opt.fillchars = { eob = " " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = false

-- disable swap file
vim.opt.swapfile = false

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- todo: prevents automatic commenting of the next line ?
-- [[ basic keymaps ]]
--  see `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- allow backspacing over autoindent, line breaks, and the start of insert
vim.opt.backspace = { "start", "eol", "indent" }

-- enabling search in subdirectories
vim.opt.path:append({ "**" })
-- ignore node_modules during file name completion
vim.opt.wildignore:append({ "*/node_modules/*" })

-- keep the cursor in the same position when closing a window
vim.opt.splitkeep = "cursor"
