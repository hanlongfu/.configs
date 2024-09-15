require("config.options")
require("config.keymaps")
require("config.autocommands")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded. This is equivalent to require('Comment').setup({})
	require("config.colorscheme"),
	require("plugins.telescope-nvim"),
	require("plugins.gitsigns"),
	require("plugins.telescope-file-browser"),
	require("plugins.dressing"),
	require("plugins.nvim-lspconfig"),
	require("plugins.conform"),
	require("plugins.nvim-cmp"),
	require("plugins.todo-comments"),
	require("plugins.comment"),
	require("plugins.nvim-ts-autotag"),
	require("plugins.nvim-colorizer"),
	require("plugins.nvim-treesitter"),
	require("plugins.lualine"),
	require("plugins.outline"),
	require("plugins.trouble"),
	require("plugins.nvim-tree"),
	require("plugins.bufferline"),
	require("plugins.nvim-autopairs"),
	require("plugins.move"),
	require("plugins.vim-tmux-navigator"),
	require("plugins.nvim-surround"),
	require("plugins.rename"),
	require("plugins.leap"),
	require("plugins.indentmini"),
	require("plugins.nvim-various-textobjs"),

	-- end of plugins, ui= {} is optional config
}, {
	ui = {
		-- If you have a Nerd Font, set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- this turns the separator line between nvim-tree and vim into a thin line
vim.opt.fillchars = { vert = "│" }
vim.cmd([[highlight VertSplit guifg=#444444 guibg=NONE]])

-- If you need to ensure this happens after colorscheme loading:
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd([[highlight VertSplit guifg=#444444 guibg=NONE]])
	end,
})
