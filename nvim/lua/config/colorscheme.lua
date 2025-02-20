return {
	"cocopon/iceberg.vim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark"
		vim.cmd("colorscheme iceberg")
	end,
}
