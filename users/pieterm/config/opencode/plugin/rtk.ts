import type { Plugin } from "@opencode-ai/plugin"

// Rewrite every bash command through rtk (token-optimizing CLI proxy).
// Mirrors the Claude Code hook: `git status` -> `rtk git status`.
// Meta commands (`rtk gain`, `rtk discover`, `rtk proxy ...`) pass through untouched.

export default (async () => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return
      const command = output.args?.command
      if (typeof command !== "string" || command.trim() === "") return
      if (command.trimStart().startsWith("rtk ")) return
      output.args.command = `rtk ${command}`
    },
  }
}) satisfies Plugin
