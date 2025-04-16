defmodule BackWeb.CommentJSON do
  alias Back.Comments.Comment

  @doc """
  Renders a list of comment.
  """
  def index(%{comment: comment}) do
    %{data: for(comment <- comment, do: data(comment))}
  end

  @doc """
  Renders a single comment.
  """
  def show(%{comment: comment}) do
    %{data: data(comment)}
  end

  defp data(%Comment{} = comment) do
    %{
      id: comment.id,
      comment_id: comment.comment_id,
      edited: comment.edited,
      contents: comment.contents
    }
  end
end
