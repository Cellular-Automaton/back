defmodule BackWeb.FavoriteJSON do
  alias Back.Favorites.Favorite

  @doc """
  Renders a list of favorite.
  """
  def index(%{favorite: favorite}) do
    %{data: for(favorite <- favorite, do: data(favorite))}
  end

  @doc """
  Renders a single favorite.
  """
  def show(%{favorite: favorite}) do
    %{data: data(favorite)}
  end

  defp data(%Favorite{} = favorite) do
    %{
      id: favorite.id,
      user_id: favorite.user_id,
      automaton_id: favorite.automaton_id
    }
  end
end
