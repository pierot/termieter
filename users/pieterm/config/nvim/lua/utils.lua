local M = {}
local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g, fn = vim.fn}

-- https://github.com/neovim/neovim/pull/13479
-- Legacy helper, consider migrating to vim.opt directly
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-- Modern keymapping function using vim.keymap.set API
function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
