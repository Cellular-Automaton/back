defmodule BackWeb.AutomatonCommentsControllerTest do
  use BackWeb.ConnCase

  import Back.AutomatonsCommentsFixtures

  alias Back.AutomatonsComments.AutomatonComments

  @create_attrs %{
    edited: true,
    contents: "some contents"
  }
  @update_attrs %{
    edited: false,
    contents: "some updated contents"
  }
  @invalid_attrs %{edited: nil, contents: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all automaton_comment", %{conn: conn} do
      conn = get(conn, ~p"/api/automaton_comment")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create automaton_comments" do
    test "renders automaton_comments when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton_comment", automaton_comments: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/automaton_comment/#{id}")

      assert %{
               "id" => ^id,
               "contents" => "some contents",
               "edited" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton_comment", automaton_comments: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update automaton_comments" do
    setup [:create_automaton_comments]

    test "renders automaton_comments when data is valid", %{
      conn: conn,
      automaton_comments: %AutomatonComments{id: id} = automaton_comments
    } do
      conn =
        put(conn, ~p"/api/automaton_comment/#{automaton_comments}",
          automaton_comments: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/automaton_comment/#{id}")

      assert %{
               "id" => ^id,
               "contents" => "some updated contents",
               "edited" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      automaton_comments: automaton_comments
    } do
      conn =
        put(conn, ~p"/api/automaton_comment/#{automaton_comments}",
          automaton_comments: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete automaton_comments" do
    setup [:create_automaton_comments]

    test "deletes chosen automaton_comments", %{
      conn: conn,
      automaton_comments: automaton_comments
    } do
      conn = delete(conn, ~p"/api/automaton_comment/#{automaton_comments}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/automaton_comment/#{automaton_comments}")
      end
    end
  end

  defp create_automaton_comments(_) do
    automaton_comments = automaton_comments_fixture()
    %{automaton_comments: automaton_comments}
  end
end
