defmodule BackWeb.AutomatonCommentsJSON do
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

  defp data(%{} = automaton_comments) do
    %{
      id: automaton_comments.id,
      edited: automaton_comments.edited,
      contents: automaton_comments.contents,
      inserted_at: automaton_comments.inserted_at,
      updated_at: automaton_comments.updated_at,
      automaton_id: automaton_comments.automaton_id,
      posted_by: automaton_comments.posted_by
    }
  end
end
