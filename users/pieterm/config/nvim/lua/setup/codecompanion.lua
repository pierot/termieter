local status, codecompanion = pcall(require, "codecompanion")
if (not status) then return end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "copilot",
    },
    agent = {
      adapter = "anthropic",
    },
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = "cmd:op read --account my.1password.com op://Noort/pxt5stwy22ezyn2iovfd47ea7e/credential --no-newline",
        },
        --[[ schema = {
          model = {
            default = "claude-3-opus-20240229",
          },
        }, ]]
      })
    end,
  }
})
