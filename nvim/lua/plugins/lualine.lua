-- better statusline at the bottom
--	dependencies = { "nvim-tree/nvim-web-devicons" },

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		-- Prepare a custom theme for base16-darcula
		local darcula_colors = {
			normal = {
				a = { fg = "#2B2B2B", bg = "#CC7832", gui = "bold" }, -- Orange
				b = { fg = "#A9B7C6", bg = "#323232" },
				c = { fg = "#A9B7C6", bg = "#2B2B2B" },
			},
			insert = {
				a = { fg = "#2B2B2B", bg = "#A5C261", gui = "bold" }, -- Green
			},
			visual = {
				a = { fg = "#2B2B2B", bg = "#9876AA", gui = "bold" }, -- Purple
			},
			replace = {
				a = { fg = "#2B2B2B", bg = "#CC7832", gui = "bold" }, -- Orange
			},
			command = {
				a = { fg = "#2B2B2B", bg = "#6897BB", gui = "bold" }, -- Blue
			},
			inactive = {
				a = { fg = "#808080", bg = "#2B2B2B", gui = "bold" },
				b = { fg = "#808080", bg = "#2B2B2B" },
				c = { fg = "#808080", bg = "#2B2B2B" },
			},
		}

		-- Create a custom theme handling function
		local custom_theme = function()
			-- If using base16-darcula, return our custom theme
			if vim.g.colors_name == "base16-darcula" then
				return darcula_colors
			end

			-- Otherwise, use the default auto theme
			return "auto"
		end

		return {
			options = {
				theme = custom_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		}
	end,
}
