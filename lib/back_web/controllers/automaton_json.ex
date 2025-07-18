defmodule BackWeb.AutomatonJSON do
  alias Back.Automatons.Automaton

  @doc """
  Renders a list of automaton.
  """
  def index(%{automaton: automatons}) do
    %{data: Enum.map(automatons, &data/1)}
  end

  defp data(%Automaton{} = automaton) do
    %{
      automaton_id: automaton.automaton_id,
      contents: automaton.contents,
      name: automaton.name,
      description: automaton.description,
      tags: Map.get(automaton, :tags, []),
      image: Map.get(automaton, :image, nil)
    }
  end

  @doc """
  Renders a single automaton.
  """
  def show(%{automaton: automaton}) do
    %{data: data(automaton)}
  end

  defp data(%Automaton{} = automaton) do
    %{
      automaton_id: automaton.automaton_id,
      contents: automaton.contents,
      name: automaton.name,
      description: automaton.description
    }
  end

  # same structure, with the images added

  def index_image(%{automaton: automaton}) do
    %{data: for(automaton <- automaton, do: data_images(automaton, automaton.tags))}
  end

  @doc """
  Render a automaton with the profile picture when needed
  """
  def show_images(%{automaton: automaton, tags: tags}) do
    IO.inspect(tags)
    %{data: data_images(automaton, tags)}
  end

  defp data_images(%{} = automaton, tags) do
    %{
      automaton_id: automaton.automaton_id,
      contents: automaton.contents,
      name: automaton.name,
      description: automaton.description,
      image: automaton.image,
      tags: tags,
      file: automaton.file
    }
  end

  @doc """
  Renders a list of automaton.
  """
  def index_date(%{automaton: automaton}) do
    %{data: for(automaton <- automaton, do: data_date(automaton))}
  end

  @doc """
  Renders a single automaton.
  """
  def show_date(%{automaton: automaton}) do
    %{data: data_date(automaton)}
  end

  defp data_date(%Automaton{} = automaton) do
    %{
      automaton_id: automaton.automaton_id,
      contents: automaton.contents,
      name: automaton.name,
      description: automaton.description,
      inserted_at: automaton.inserted_at,
      updated_at: automaton.updated_at
    }
  end
end
