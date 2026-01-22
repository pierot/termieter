-- ==========================================================================
--  PERFORMANCE & GLOBALS
-- ==========================================================================
-- Set leader BEFORE anything else to ensure plugins pick it up correctly
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.loader.enable() -- Accelerates Lua module loading

-- Disable providers we don't use (Measurable startup improvement)
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- Disable built-in plugins we don't use
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("opts")

-- Setup lazy.nvim
require("lazy").setup("plugins", {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

print("Jack + Joe rocks!")
