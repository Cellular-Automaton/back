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
      |> Enum.into(%{

      })
      |> Back.Favorites.create_favorite()

    favorite
  end
end
