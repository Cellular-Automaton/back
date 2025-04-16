defmodule BackWeb.AutomatonControllerTest do
  use BackWeb.ConnCase

  import Back.AutomatonsFixtures

  alias Back.Automatons.Automaton

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

  describe "create automaton" do
    test "renders automaton when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton", automaton: @create_attrs)
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
      conn = post(conn, ~p"/api/automaton", automaton: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update automaton" do
    setup [:create_automaton]

    test "renders automaton when data is valid", %{
      conn: conn,
      automaton: %Automaton{id: id} = automaton
    } do
      conn = put(conn, ~p"/api/automaton/#{automaton}", automaton: @update_attrs)
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

    test "renders errors when data is invalid", %{conn: conn, automaton: automaton} do
      conn = put(conn, ~p"/api/automaton/#{automaton}", automaton: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete automaton" do
    setup [:create_automaton]

    test "deletes chosen automaton", %{conn: conn, automaton: automaton} do
      conn = delete(conn, ~p"/api/automaton/#{automaton}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/automaton/#{automaton}")
      end
    end
  end

  defp create_automaton(_) do
    automaton = automaton_fixture()
    %{automaton: automaton}
  end
end
