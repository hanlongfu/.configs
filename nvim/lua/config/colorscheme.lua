-- try kangawa colorscheme
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

	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({})
		vim.cmd.colorscheme("tokyonight")
	end,
}
