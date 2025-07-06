local config = require("plugins.configs")

return {
	{
		--  Startup menu
		-- "goolord/alpha-nvim",
		-- -- lazy = false,
		-- dependencies = { "DaikyXendo/nvim-material-icon" },
		-- config = function()
		-- 	config.alpha()
		-- end,
	},
	-- Theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "BufAdd",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		config = function()
			config.lualine()
		end,
	},
	{
		"folke/which-key.nvim",
		keys = " ",
		init = function()
			require("which-key").setup()
		end,
	},
	{
		"chikko80/error-lens.nvim",
		event = "BufAdd",
		requires = { "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufAdd",
		main = "ibl",
		opts = {},
		config = function()
			config.ibl()
		end,
	},
	{
		"DaikyXendo/nvim-material-icon",
		lazy = false,
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufAdd",
		init = function()
			config.gits()
		end,
	},
}
