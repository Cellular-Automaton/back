defmodule BackWeb.TagJSON do
  alias Back.Automatons.Tags.Tag

  @doc """
  Renders a list of tag.
  """
  def index(%{tag: tag}) do
    %{data: for(tag <- tag, do: data(tag))}
  end

  @doc """
  Renders a single tag.
  """
  def show(%{tag: tag}) do
    %{data: data(tag)}
  end

  defp data(%Tag{} = tag) do
    %{
      id: tag.id,
      name: tag.name,
      description: tag.description
    }
  end
end
