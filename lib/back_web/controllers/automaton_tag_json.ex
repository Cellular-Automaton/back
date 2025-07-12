defmodule BackWeb.AutomatonTagJSON do
  alias Back.Automatons.AutomatonTags.AutomatonTag

  @doc """
  Renders a list of automaton_tag.
  """
  def index(%{automaton_tag: automaton_tag}) do
    %{data: for(automaton_tag <- automaton_tag, do: data(automaton_tag))}
  end

  @doc """
  Renders a single automaton_tag.
  """
  def show(%{automaton_tag: automaton_tag}) do
    %{data: data(automaton_tag)}
  end

  defp data(%AutomatonTag{} = automaton_tag) do
    %{
      id: automaton_tag.id,
      tag_id: automaton_tag.tag_id,
      automaton_id: automaton_tag.automaton_id
    }
  end
end
