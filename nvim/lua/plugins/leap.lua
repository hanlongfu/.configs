return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")
		leap.create_default_mappings()
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "white",
			bold = true,
			nocombine = true,
		})
	end,
}
