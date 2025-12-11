-- Codeium keybindings setup
-- These need to be set up explicitly to override any conflicts

vim.keymap.set("i", "<Tab>", function()
	-- Check if nvim-cmp menu is visible
	local cmp = require("cmp")
	if cmp.visible() then
		cmp.select_next_item()
	else
		-- Try to accept Codeium virtual text suggestion
		local codeium = require("codeium.virtual_text")
		if codeium.accept() == 0 then
			-- No suggestion to accept, insert tab
			return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
		end
	end
end, { expr = true, silent = true, desc = "Accept Codeium suggestion or navigate cmp" })

vim.keymap.set("i", "<C-]>", function()
	require("codeium.virtual_text").cycle_or_complete()
end, { silent = true, desc = "Cycle to next Codeium suggestion" })

--[[ vim.keymap.set("i", "<C-w>", function()
	require("codeium.virtual_text").accept_word()
end, { silent = true, desc = "Accept next word of Codeium suggestion" }) ]]

--[[ vim.keymap.set("i", "<C-\\>", function()
	require("codeium.virtual_text").clear()
end, { silent = true, desc = "Clear Codeium suggestion" }) ]]
