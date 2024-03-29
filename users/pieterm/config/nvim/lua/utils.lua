local M = {}
local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g, fn = vim.fn}

-- https://github.com/neovim/neovim/pull/13479
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
