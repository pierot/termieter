import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  colors: [
    eval_result: [:green, :bright],
    eval_error: [[:red, :bright, "Bug Bug ..!!"]],
    eval_info: [:yellow, :bright]
  ],
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      :green,
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
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)

# defmodule AC do
#   IEx.configure(
#     colors: [
#       syntax_colors: [
#         number: :light_yellow,
#         atom: :light_cyan,
#         string: :light_black,
#         boolean: [:light_blue],
#         nil: [:magenta, :bright]
#       ],
#       eval_result: [:green, :bright],
#       eval_error: [[:red, :bright, "Bug Bug ..!!"]],
#       eval_info: [:yellow, :bright],
#       ls_directory: :cyan,
#       ls_device: :yellow,
#       doc_code: :green,
#       doc_inline_code: :magenta,
#       doc_headings: [:cyan, :underline],
#       doc_title: [:cyan, :bright, :underline]
#     ],
#     default_prompt:
#     [
#       # ANSI CHA, move cursor to column 1
#       "\e[G",
#       :light_magenta,
#       # plain string
#       "iex",
#       ">",
#       :white,
#       :reset
#     ]
#     |> IO.ANSI.format()
#     |> IO.chardata_to_string()
#   )
# end
