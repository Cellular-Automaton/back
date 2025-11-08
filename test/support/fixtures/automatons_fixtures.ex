defmodule Back.AutomatonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Automatons` context.
  """

  @doc """
  Generate a automaton.
  """
  def automaton_fixture(attrs \\ %{}) do
    {:ok, automaton} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        description: "some description",
        name: "some name"
      })
      |> Back.Automatons.create_automaton()

    automaton
  end

  def automaton_fixture_preload(attrs \\ %{}) do
    {:ok, automaton} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        description: "some description",
        name: "some name"
      })
      |> Back.Automatons.create_automaton()

    automaton
    |> Back.Repo.preload([:image])
  end
end
