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
		vim.notify("✓ Switched to GitHub Copilot", vim.log.levels.INFO, { title = "AI Assistant" })
	else
		-- Switch to Codeium
		vim.cmd("Copilot disable")
		vim.cmd("Codeium Toggle") -- Enable Codeium
		current_ai = "codeium"
		vim.notify("✓ Switched to Codeium", vim.log.levels.INFO, { title = "AI Assistant" })
	end
end

function M.status()
	local status = current_ai == "codeium" and "Codeium" or "GitHub Copilot"
	vim.notify("Currently using: " .. status, vim.log.levels.INFO, { title = "AI Assistant" })
end

return M
