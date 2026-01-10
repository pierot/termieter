import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

# IO.puts(
#   IO.ANSI.magenta_background() <>
#     IO.ANSI.white() <> " ❄❄❄ All things serve the BEAM ❄❄❄ " <> IO.ANSI.reset()
# )

Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  colors: [
    eval_result: [:green, :bright],
    eval_error: [[:red, :bright, "Bug Bug ..!!"]],
    eval_info: [:yellow, :bright],
    # syntax_colors: [
    #   map: :magenta
    # ],
  ],
  default_prompt:
    [
      "%prefix",
      :white,
      "|",
      :blue,
      "%counter",
      :white,
      "|",
      :red,
      # plain string
      "▶",
      :white,
      # plain string
      "▶▶",
      # ❤ ❤-»" ,  # plain string
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)
