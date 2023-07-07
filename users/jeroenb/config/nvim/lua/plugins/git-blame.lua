local status, gitblame = pcall(require, "gitblame")
if (not status) then return end

vim.g.gitblame_enabled = 0
