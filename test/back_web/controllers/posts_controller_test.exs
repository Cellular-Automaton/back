defmodule BackWeb.PostsControllerTest do
  use BackWeb.ConnCase

  import Back.AutomatonFixtures

  alias Back.Automaton.Posts

  @create_attrs %{
    name: "some name",
    description: "some description",
    automaton_id: "some automaton_id",
    contents: "some contents"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    automaton_id: "some updated automaton_id",
    contents: "some updated contents"
  }
  @invalid_attrs %{name: nil, description: nil, automaton_id: nil, contents: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all automaton", %{conn: conn} do
      conn = get(conn, ~p"/api/automaton")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create posts" do
    test "renders posts when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton", posts: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/automaton/#{id}")

      assert %{
               "id" => ^id,
               "automaton_id" => "some automaton_id",
               "contents" => "some contents",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton", posts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update posts" do
    setup [:create_posts]

    test "renders posts when data is valid", %{conn: conn, posts: %Posts{id: id} = posts} do
      conn = put(conn, ~p"/api/automaton/#{posts}", posts: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/automaton/#{id}")

      assert %{
               "id" => ^id,
               "automaton_id" => "some updated automaton_id",
               "contents" => "some updated contents",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, posts: posts} do
      conn = put(conn, ~p"/api/automaton/#{posts}", posts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete posts" do
    setup [:create_posts]

    test "deletes chosen posts", %{conn: conn, posts: posts} do
      conn = delete(conn, ~p"/api/automaton/#{posts}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/automaton/#{posts}")
      end
    end
  end

  defp create_posts(_) do
    posts = posts_fixture()
    %{posts: posts}
  end
end
