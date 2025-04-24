defmodule Back.FavoritesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Favorites` context.
  """

  @doc """
  Generate a favorite.
  """
  def favorite_fixture(attrs \\ %{}) do
    {:ok, favorite} =
      attrs
      |> Enum.into(
        %{
          # user_id: "some user_id",
          # automaton_id: "some automaton_id"
        }
      )
      |> Back.Favorites.create_favorite()

    favorite
  end
end
