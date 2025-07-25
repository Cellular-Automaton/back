defmodule Back.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        comment_id: "some comment_id",
        contents: "some contents",
        edited: true
      })
      |> Back.Comments.create_comment()

    comment
  end
end
