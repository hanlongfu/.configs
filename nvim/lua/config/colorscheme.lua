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
		require("tokyonight").setup({
			style = "night",
			transparent = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
			},
			on_highlights = function(hl, c)
				-- default colors too faint for line numbers and comments
				hl.Comment = { fg = c.dark5 }
				hl.LineNr = { fg = c.dark5 }
				hl.LineNrAbove = { fg = c.dark5 }
				hl.LineNrBelow = { fg = c.dark5 }
				hl.NvimTreeNormal = { bg = c.bg }
			end,
		})
		vim.cmd.colorscheme("tokyonight")
	end,
}
