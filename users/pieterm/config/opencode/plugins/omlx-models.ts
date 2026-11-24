import { Plugin } from "@opencode/plugin"
import { readFileSync } from "node:fs"
import { homedir } from "node:os"

// Adds each chat model that oMLX serves to the provider "omlx".
// A model with an entry in opencode.jsonc keeps that entry.
// The URL and the key file are equal to providers.omlx.settings in opencode.jsonc.
const MODELS_URL = "http://127.0.0.1:9000/v1/models"
const KEY_FILE = `${homedir()}/.omlx/opencode.key`
const REFRESH_MS = 60_000

type OmlxModel = { id: string; model_type: string; max_model_len: number | null }

async function fetchModels(): Promise<OmlxModel[]> {
  const key = readFileSync(KEY_FILE, "utf8").trim()
  const response = await fetch(MODELS_URL, {
    headers: { Authorization: `Bearer ${key}` },
    signal: AbortSignal.timeout(2000),
  })
  const { data } = (await response.json()) as { data: OmlxModel[] }
  return data.filter((model) => model.model_type === "llm" || model.model_type === "vlm")
}

export default Plugin.define({
  id: "omlx-models",
  async setup(ctx) {
    let models: OmlxModel[] = []
    await ctx.model.transform((editor) => {
      for (const model of models) {
        if (editor.get("omlx", model.id)) continue
        editor.update("omlx", model.id, (draft) => {
          draft.capabilities.input = model.model_type === "vlm" ? ["text", "image"] : ["text"]
          if (model.max_model_len) draft.limit.context = model.max_model_len
          // The TUI model dialog lists a local model only when the model has a cost of 0.
          draft.cost = [{ input: 0, output: 0, cache: { read: 0, write: 0 } }]
        })
      }
    })
    const refresh = async () => {
      // When oMLX does not answer, the last list stays.
      const next = await fetchModels().catch(() => undefined)
      if (!next || JSON.stringify(next) === JSON.stringify(models)) return
      models = next
      await ctx.model.reload()
    }
    await refresh()
    const timer = setInterval(() => void refresh(), REFRESH_MS)
    return () => clearInterval(timer)
  },
})
