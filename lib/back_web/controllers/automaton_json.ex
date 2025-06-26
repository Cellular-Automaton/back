defmodule BackWeb.AutomatonJSON do
  alias Back.Automatons.Automaton

  @doc """
  Renders a list of automaton.
  """
  def index(%{automaton: automaton}) do
    %{data: for(automaton <- automaton, do: data(automaton))}
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
    %{data: for(automaton <- automaton, do: data_images(automaton))}
  end

  @doc """
  Render a automaton with the profile picture when needed
  """
  def show_images(%{automaton: automaton}) do
    %{data: data_images(automaton)}
  end

  defp data_images(%{} = automaton) do
    %{
      automaton_id: automaton.automaton_id,
      contents: automaton.contents,
      name: automaton.name,
      description: automaton.description,
      image: automaton.image
    }
  end
end
