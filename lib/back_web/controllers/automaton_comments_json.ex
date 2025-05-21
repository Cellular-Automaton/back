defmodule BackWeb.AutomatonCommentsJSON do
  alias Back.AutomatonsComments.AutomatonComments

  @doc """
  Renders a list of automaton_comment.
  """
  def index(%{automaton_comment: automaton_comment}) do
    %{data: for(automaton_comments <- automaton_comment, do: data(automaton_comments))}
  end

  @doc """
  Renders a single automaton_comments.
  """
  def show(%{automaton_comments: automaton_comments}) do
    %{data: data(automaton_comments)}
  end

  defp data(%AutomatonComments{} = automaton_comments) do
    %{
      id: automaton_comments.id,
      edited: automaton_comments.edited,
      contents: automaton_comments.contents
    }
  end
end
