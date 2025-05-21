defmodule Back.AutomatonsCommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.AutomatonsComments` context.
  """

  @doc """
  Generate a automaton_comments.
  """
  def automaton_comments_fixture(attrs \\ %{}) do
    {:ok, automaton_comments} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        edited: true
      })
      |> Back.AutomatonsComments.create_automaton_comments()

    automaton_comments
  end
end
