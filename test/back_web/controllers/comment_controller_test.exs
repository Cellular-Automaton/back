defmodule BackWeb.CommentControllerTest do
  use BackWeb.ConnCase

  import Back.CommentsFixtures

  alias Back.Comments.Comment

  @create_attrs %{
    comment_id: "some comment_id",
    edited: true,
    contents: "some contents"
  }
  @update_attrs %{
    comment_id: "some updated comment_id",
    edited: false,
    contents: "some updated contents"
  }
  @invalid_attrs %{comment_id: nil, edited: nil, contents: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comment", %{conn: conn} do
      conn = get(conn, ~p"/api/comment")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create comment" do
    test "renders comment when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/comment", comment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/comment/#{id}")

      assert %{
               "id" => ^id,
               "comment_id" => "some comment_id",
               "contents" => "some contents",
               "edited" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/comment", comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "renders comment when data is valid", %{conn: conn, comment: %Comment{id: id} = comment} do
      conn = put(conn, ~p"/api/comment/#{comment}", comment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/comment/#{id}")

      assert %{
               "id" => ^id,
               "comment_id" => "some updated comment_id",
               "contents" => "some updated contents",
               "edited" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, ~p"/api/comment/#{comment}", comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, ~p"/api/comment/#{comment}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/comment/#{comment}")
      end
    end
  end

  defp create_comment(_) do
    comment = comment_fixture()
    %{comment: comment}
  end
end
