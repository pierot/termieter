return {
  "hrsh7th/nvim-cmp",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Start interactive EasyAlign in visual mode (e.g. vipga)
    vim.cmd("xmap ga <Plug>(EasyAlign)")

    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
    vim.cmd("nmap ga <Plug>(EasyAlign)")
  end
}
