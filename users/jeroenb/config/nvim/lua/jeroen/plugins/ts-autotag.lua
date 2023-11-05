--[[ local setup, autotag = pcall(require, "nvim-ts-autotag")
if (not setup) then return end

autotag.setup({}) ]]

return {
  'windwp/nvim-ts-autotag',
  event = { "BufReadPre", "BufNewFile" },
  config = true,
}
