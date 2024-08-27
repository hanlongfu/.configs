return {
	"nvimdev/indentmini.nvim",
	config = function()
		require("indentmini").setup()

		vim.cmd.highlight("IndentLine guifg =#547998")
		vim.cmd.highlight("IndentLineCurrent guifg=#0A64A7")
	end,
}
