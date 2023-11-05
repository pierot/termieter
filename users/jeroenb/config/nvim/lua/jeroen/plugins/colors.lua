function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

return {
	'rktjmp/lush.nvim',
	'metalelf0/jellybeans-nvim',
	'norcalli/nvim-colorizer.lua',
	'gruvbox-community/gruvbox'  ,
  'catppuccin/nvim',
  {
    'folke/tokyonight.nvim',
    config = function()
      --vim.cmd("colorscheme jellybeans-nvim")
      --vim.cmd("colorscheme gruvbox")
      -- vim.cmd("colorscheme tokyonight-night")

      -- u.map('n', '<silent> [oh', ':call gruvbox#hls_show()<CR>')
      -- u.map('n', '<silent> ]oh', ':call gruvbox#hls_hide()<CR>')
      -- u.map('n', '<silent> coh', ':call gruvbox#hls_toggle()<CR>')

      vim.cmd("colorscheme tokyonight-night")
      vim.keymap.set('n', '<F5>', ':lua ToggleTheme()<CR>')           -- Switch between windows by hitting <Tab> twice
    end
  }
}
