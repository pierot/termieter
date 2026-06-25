return {
	"milanglacier/minuet-ai.nvim",
	-- Load before filetypes are assigned: minuet arms auto-trigger via a FileType
	-- autocmd, so loading on InsertEnter would miss the buffer you're already in.
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("minuet").setup({
			-- Local Ollama (Vulkan backend) via the OpenAI-compatible FIM endpoint.
			provider = "openai_fim_compatible",
			n_completions = 1, -- one suggestion = lower latency for inline ghost text
			-- Chars of context sent each completion. minuet's docs suggest starting
			-- at 512 for local models (the prompt is processed on every trigger);
			-- 2000 is a small, fast prompt with room for your RX 6600. Raise for more
			-- context, lower if it feels laggy.
			context_window = 2000,
			provider_options = {
				openai_fim_compatible = {
					-- Ollama needs no key. minuet reads the env var *named* here,
					-- so point it at one that always exists.
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://localhost:11434/v1/completions",
					model = "qwen2.5-coder:7b", -- swap to ":3b" for snappier/lighter
					optional = {
						max_tokens = 128, -- docs use 56 for local; 128 allows a few lines
						top_p = 0.9,
					},
				},
			},
			-- Inline ghost-text suggestions (the supermaven-style UX).
			virtualtext = {
				auto_trigger_ft = { "*" }, -- all filetypes; "" or a list to scope
				keymap = {
					accept = "<C-y>", -- accept full suggestion (same key supermaven used)
					accept_line = "<M-Right>", -- accept one line
					prev = "<M-[>",
					next = "<M-]>",
					dismiss = "<C-]>", -- same key supermaven used to clear
				},
				show_on_completion_menu = false,
			},
		})
	end,
}
