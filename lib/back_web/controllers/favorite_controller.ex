defmodule BackWeb.FavoriteController do
  use BackWeb, :controller

  alias Back.Favorites
  alias Back.Favorites.Favorite

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    favorite = Favorites.list_favorite()
    render(conn, :index, favorite: favorite)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    with {:ok, %Favorite{} = favorite} <- Favorites.create_favorite(favorite_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/favorite/#{favorite}")
      |> render(:show, favorite: favorite)
    end
  end

  def show(conn, %{"id" => id}) do
    favorite = Favorites.get_favorite!(id)
    render(conn, :show, favorite: favorite)
  end

  def update(conn, %{"id" => id, "favorite" => favorite_params}) do
    favorite = Favorites.get_favorite!(id)

    with {:ok, %Favorite{} = favorite} <- Favorites.update_favorite(favorite, favorite_params) do
      render(conn, :show, favorite: favorite)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Favorites.get_favorite!(id)

    with {:ok, %Favorite{}} <- Favorites.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
