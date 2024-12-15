local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

M.live_multigrep = function(opts)
	print("Lua multigrep")
	opts = opts or {}
	opts.cwd = opts.cwd or "." -- vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }

			print(vim.inspect(args))

			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			-- if pieces[2] then
			-- 	table.insert(args, "-g")
			-- 	table.insert(args, pieces[2])
			-- end

			return vim.tbl.flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			finder = finder,
			previwer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

return M
