defmodule BackWeb.PostActionsControllerTest do
  use BackWeb.ConnCase

  import Back.Posts.PostActionsFixtures

  alias Back.Posts.PostActions.PostActions

  @create_attrs %{
    action: "some action"
  }
  @update_attrs %{
    action: "some updated action"
  }
  @invalid_attrs %{action: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts_actions", %{conn: conn} do
      conn = get(conn, ~p"/api/posts_actions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post_actions" do
    test "renders post_actions when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts_actions", post_actions: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/posts_actions/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some action"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts_actions", post_actions: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post_actions" do
    setup [:create_post_actions]

    test "renders post_actions when data is valid", %{
      conn: conn,
      post_actions: %PostActions{id: id} = post_actions
    } do
      conn = put(conn, ~p"/api/posts_actions/#{post_actions}", post_actions: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/posts_actions/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some updated action"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post_actions: post_actions} do
      conn = put(conn, ~p"/api/posts_actions/#{post_actions}", post_actions: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post_actions" do
    setup [:create_post_actions]

    test "deletes chosen post_actions", %{conn: conn, post_actions: post_actions} do
      conn = delete(conn, ~p"/api/posts_actions/#{post_actions}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/posts_actions/#{post_actions}")
      end
    end
  end

  defp create_post_actions(_) do
    post_actions = post_actions_fixture()
    %{post_actions: post_actions}
  end
end
