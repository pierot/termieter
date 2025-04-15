# Temporarily Disabled Redundant Neovim Configuration

This document explains what has been disabled to test for redundant functionality.

## 1. CoC vs Native LSP

CoC (Conquer of Completion) has been disabled while testing the native LSP setup.

### How it was disabled:
- Added `let g:coc_start_at_startup = 0` to init.vim
- Original coc-settings.json backed up to coc-settings.json.bak

### To restore:
- Remove or comment out `let g:coc_start_at_startup = 0` from init.vim

## 2. Multiple Formatters (prettier.nvim vs conform.nvim)

prettier.nvim has been disabled while testing conform.nvim for formatting.

### How it was disabled:
- Commented out `require("setup.prettier")` in setup.lua
- Original prettier.lua backed up to prettier.lua.bak

### To restore:
- Uncomment `require("setup.prettier")` in setup.lua

## Testing
After these changes, the system should:
- Use only native LSP for completion, diagnostics, and code actions
- Use only conform.nvim for formatting

If you experience any issues:
1. Check logs with `:messages`
2. Verify which LSP servers are running with `:LspInfo`
3. Test formatting with `:lua vim.lsp.buf.format()`

## Note
These changes are intended to be temporary for testing purposes. If they work well, 
you may want to permanently remove the redundant components to simplify your Neovim configuration.