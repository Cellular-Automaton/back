defmodule Mix.Tasks.Generate.RoutesDocs do
  use Mix.Task

  def run(_) do
    {routes, _status} = System.cmd("mix", ["phx.routes"], stderr_to_stdout: true)

    markdown = generate_markdown(routes)
    File.write!("priv/static/routes.md", "```\n" <> markdown <> "```")
  end

  defp generate_markdown(routes) do
    routes
    |> String.split("\n")
    |> Enum.map(&format_route/1)
    |> Enum.join("\n")
  end

  defp format_route(line) do
    if String.starts_with?(line, "     ") do
      "| " <> String.trim(line) <> " |"
    else
      line
    end
  end
end
