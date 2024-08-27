-- recognize color hex code
return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup()
	end,
}
