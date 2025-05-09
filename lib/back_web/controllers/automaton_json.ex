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
end
