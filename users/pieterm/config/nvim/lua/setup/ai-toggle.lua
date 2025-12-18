-- Toggle between Copilot and Codeium AI assistants

local M = {}

-- Track which AI assistant is currently active
local current_ai = "codeium" -- Start with Codeium by default

function M.toggle()
	if current_ai == "codeium" then
		-- Switch to Copilot
		vim.cmd("Codeium Toggle") -- Disable Codeium
		vim.cmd("Copilot enable")
		current_ai = "copilot"
    vim.g.copilot_no_tab_map = false -- Enable Copilot's Tab mapping to allow Codeium to use it
		vim.notify("✓ Switched to GitHub Copilot", vim.log.levels.INFO, { title = "AI Assistant" })
	else
		-- Switch to Codeium
		vim.cmd("Copilot disable")
		vim.cmd("Codeium Toggle") -- Enable Codeium
    vim.g.copilot_no_tab_map = true -- Disable Copilot's Tab mapping to allow Codeium to use it
		current_ai = "codeium"
		vim.notify("✓ Switched to Codeium", vim.log.levels.INFO, { title = "AI Assistant" })
	end
end

function M.status()
	local status = current_ai == "codeium" and "Codeium" or "GitHub Copilot"
	vim.notify("Currently using: " .. status, vim.log.levels.INFO, { title = "AI Assistant" })
end

-- Create user commands for toggling between AI assistants
vim.api.nvim_create_user_command("AIToggle", function()
	M.toggle()
end, { desc = "Toggle between Copilot and Codeium" })

vim.api.nvim_create_user_command("AIStatus", function()
	M.status()
end, { desc = "Show current AI assistant" })

return M
