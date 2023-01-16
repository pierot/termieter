local setup, autopairs = pcall(require, "nvim-autopairs")
if (not setup) then return end

autopairs.setup({
  check_ts = true, -- enable treesitter
  disable_filetype = { "TelescopePrompt" , "vim" },
})
