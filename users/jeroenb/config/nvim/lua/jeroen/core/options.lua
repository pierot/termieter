-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- saving
vim.g.confirm = true

-- tabs & indentation
local indent = 2
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true

-- line wrapping
vim.opt.wrap = false

-- search
vim.opt.hlsearch = true -- Highlight search things
vim.opt.incsearch = true -- Make search act like search in modern browsers
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Don't ignore case with capitals

-- cursor line
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

-- appearance
vim.opt.termguicolors = true -- True color support
vim.opt.signcolumn = "yes"

-- backspace
vim.opt.backspace = "indent,eol,start"

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-- split windows
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitbelow = true -- Put new windows below current

-- ?
vim.opt.iskeyword:append("-") -- Dashes are parts of words too

-- correct title in kitty/terminal
vim.opt.title = true

-- no ack, use ripgrep
vim.g.ackprg = "rg -F -S --color=never --no-heading --with-filename --line-number --column -g !package-lock.json"

-- terminal is auto insert
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})
