defmodule Back.Automatons.AutomatonTagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Automatons.AutomatonTags` context.
  """

  @doc """
  Generate a automaton_tag.
  """
  def automaton_tag_fixture(attrs \\ %{}) do
    {:ok, automaton_tag} =
      attrs
      |> Enum.into(%{})
      |> Back.Automatons.AutomatonTags.create_automaton_tag()

    automaton_tag
  end
end
