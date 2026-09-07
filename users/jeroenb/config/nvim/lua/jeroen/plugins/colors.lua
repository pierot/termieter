return {
	-- kanagawa is kept as the light/alternate option and matches the herdr theme.
	{ "rebelot/kanagawa.nvim", lazy = true },

	{
		"EdenEast/nightfox.nvim",
		lazy = false, -- the active colorscheme, so load it at startup
		priority = 1000, -- before all other start plugins
		config = function()
			-- Palettes are the base color defines of a colorscheme.
			-- You can override these palettes for each colorscheme defined by nightfox.
			local palettes = {
				-- Everything defined under `all` will be applied to each style.
				all = {},
				carbonfox = {
					-- A palette also defines the following:
					--   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
					bg0 = "#000000",
					bg1 = "#000000",

					-- comment is the definition of the comment color.
					comment = "#fec47c",
				},
			}

			local groups = {
				carbonfox = {
					NeogitDiffAdd = { fg = "palette.green.bright", bg = "#0a2a0a" },
					NeogitDiffAddHighlight = { fg = "palette.green.bright", bg = "#0a2a0a" },
					NeogitDiffDelete = { fg = "palette.red.bright", bg = "#2a0a0a" },
					NeogitDiffDeleteHighlight = { fg = "palette.red.bright", bg = "#2a0a0a" },
				},
			}

			require("nightfox").setup({ palettes = palettes, groups = groups })

			vim.cmd("colorscheme carbonfox")
		end,
	},
}
