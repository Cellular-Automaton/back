defmodule Back.Automatons.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Automatons.Tags` context.
  """

  @doc """
  Generate a unique tag name.
  """
  def unique_tag_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: unique_tag_name()
      })
      |> Back.Automatons.Tags.create_tag()

    tag
  end
end
