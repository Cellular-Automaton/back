defmodule BackWeb.FavoriteControllerTest do
  use BackWeb.ConnCase

  import Back.FavoritesFixtures

  alias Back.Favorites.Favorite

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all favorite", %{conn: conn} do
      conn = get(conn, ~p"/api/favorite")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create favorite" do
    test "renders favorite when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/favorite", favorite: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/favorite/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/favorite", favorite: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update favorite" do
    setup [:create_favorite]

    test "renders favorite when data is valid", %{
      conn: conn,
      favorite: %Favorite{id: id} = favorite
    } do
      conn = put(conn, ~p"/api/favorite/#{favorite}", favorite: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/favorite/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, favorite: favorite} do
      conn = put(conn, ~p"/api/favorite/#{favorite}", favorite: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite" do
    setup [:create_favorite]

    test "deletes chosen favorite", %{conn: conn, favorite: favorite} do
      conn = delete(conn, ~p"/api/favorite/#{favorite}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/favorite/#{favorite}")
      end
    end
  end

  defp create_favorite(_) do
    favorite = favorite_fixture()
    %{favorite: favorite}
  end
end
