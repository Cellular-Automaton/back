defmodule Back.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        disliked_by: "some disliked_by",
        edited: true,
        liked_by: "some liked_by",
        post_id: "some post_id",
        posted_by: "some posted_by",
        title: "some title",
        viewed_by: "some viewed_by"
      })
      |> Back.Posts.create_post()

    post
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        edited: true,
        post_id: "some post_id",
        title: "some title"
      })
      |> Back.Posts.create_post()

    post
  end
end
