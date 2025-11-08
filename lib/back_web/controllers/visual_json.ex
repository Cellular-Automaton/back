defmodule BackWeb.VisualJSON do
  alias Back.Visuals.Visual

  @doc """
  Renders a list of visuals.
  """
  def index(%{visuals: visuals}) do
    %{data: for(visual <- visuals, do: data(visual))}
  end

  @doc """
  Renders a single visual.
  """
  def show(%{visual: visual}) do
    %{data: data(visual)}
  end

  defp data(%Visual{} = visual) do
    %{
      id: visual.id,
      name: visual.name,
      description: visual.description,
      assets_link: visual.assets_link
    }
  end
end
