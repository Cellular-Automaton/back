defmodule BackWeb.PostControllerTest do
  use BackWeb.ConnCase

  import Back.PostsFixtures

  alias Back.Posts.Post

  @create_attrs %{
    title: "some title",
    post_id: "some post_id",
    edited: true,
    contents: "some contents"
  }
  @update_attrs %{
    title: "some updated title",
    post_id: "some updated post_id",
    edited: false,
    contents: "some updated contents"
  }
  @invalid_attrs %{title: nil, post_id: nil, edited: nil, contents: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all post", %{conn: conn} do
      conn = get(conn, ~p"/api/post")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/post", post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/post/#{id}")

      assert %{
               "id" => ^id,
               "contents" => "some contents",
               "edited" => true,
               "post_id" => "some post_id",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/post", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/post/#{post}", post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/post/#{id}")

      assert %{
               "id" => ^id,
               "contents" => "some updated contents",
               "edited" => false,
               "post_id" => "some updated post_id",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/api/post/#{post}", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/api/post/#{post}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/post/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
