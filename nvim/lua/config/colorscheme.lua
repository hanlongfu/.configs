return {
	-- "rebelot/kanagawa.nvim",
	-- priority = 1000,
	-- name = "kanagawa",
	-- init = function()
	-- 	require("kanagawa").setup({
	-- 		commentStyle = { italic = false },
	-- 		keywordStyle = { italic = false },
	-- 		diminActive = true,
	-- 		transparent = true,
	-- 		overrides = function()
	-- 			return {
	-- 				["@variable.builtin"] = { italic = false },
	-- 				TreesitterContext = { bg = "NONE" },
	-- 				TreesitterContextLineNumber = { bg = "NONE" },
	-- 			}
	-- 		end,
	-- 	})
	-- 	vim.cmd.colorscheme("kanagawa-wave")
	-- end,

	"bluz71/vim-nightfly-colors",
	priority = 1000,
	namee = "nightfly",
	lazy = false,
	config = function()
		vim.g.nightflyCursorColor = true
		vim.g.nightflyTransparent = true
		vim.cmd.colorscheme("nightfly")
		vim.g.nightflyItalics = false
		vim.g.nightflyTerminalColors = true
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "GutterBg", { bg = "NONE" })
		vim.cmd([[colorscheme nightfly]])
	end,
}
