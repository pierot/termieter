-- Codeium integration for nvim-cmp and virtual text (ghost text)
-- Note: Codeium source is added to cmp in setup/snippets.lua
-- Note: Tab keybinding for ghost text is handled by cmp's fallback mechanism + Codeium's built-in Tab mapping

-- Check if Codeium plugin is actually available
local has_codeium, _ = pcall(require, "codeium")
if not has_codeium then
	-- Plugin not installed yet, skip setup
	return
end

-- Tab handling:
-- 1. If cmp menu is visible -> Tab navigates menu (handled by snippets.lua)
-- 2. If no cmp menu -> cmp fallback() -> Codeium's Tab mapping accepts ghost text
-- 3. If no ghost text -> Codeium's fallback -> normal Tab insertion

-- No additional Tab keybindings needed here!
