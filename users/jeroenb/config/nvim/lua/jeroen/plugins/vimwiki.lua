return {
	"vimwiki/vimwiki",
	init = function()
		vim.g.vimwiki_list = {
			{
				path = "~/Dropbox/vimwiki",
				syntax = "default",
				ext = ".wiki",
			},
		}
	end,
}
