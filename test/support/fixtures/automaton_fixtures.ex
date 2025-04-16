defmodule Back.AutomatonFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Automaton` context.
  """

  @doc """
  Generate a posts.
  """
  def posts_fixture(attrs \\ %{}) do
    {:ok, posts} =
      attrs
      |> Enum.into(%{
        automaton_id: "some automaton_id",
        contents: "some contents",
        description: "some description",
        name: "some name"
      })
      |> Back.Automaton.create_posts()

    posts
  end
end
