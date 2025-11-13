defmodule BackWeb.AutomatonTagControllerTest do
  use BackWeb.ConnCase

  import Back.Automatons.AutomatonTagsFixtures

  alias Back.Automatons.AutomatonTags.AutomatonTag

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    @tag :skip
    test "lists all automaton_tag", %{conn: conn} do
      conn = get(conn, ~p"/api/automaton_tag")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create automaton_tag" do
    @tag :skip
    test "renders automaton_tag when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton_tag", automaton_tag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/automaton_tag/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/automaton_tag", automaton_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update automaton_tag" do
    setup [:create_automaton_tag]

    @tag :skip
    test "renders automaton_tag when data is valid", %{
      conn: conn,
      automaton_tag: %AutomatonTag{id: id} = automaton_tag
    } do
      conn = put(conn, ~p"/api/automaton_tag/#{automaton_tag}", automaton_tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/automaton_tag/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, automaton_tag: automaton_tag} do
      conn = put(conn, ~p"/api/automaton_tag/#{automaton_tag}", automaton_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete automaton_tag" do
    setup [:create_automaton_tag]

    @tag :skip
    test "deletes chosen automaton_tag", %{conn: conn, automaton_tag: automaton_tag} do
      conn = delete(conn, ~p"/api/automaton_tag/#{automaton_tag}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/automaton_tag/#{automaton_tag}")
      end
    end
  end

  defp create_automaton_tag(_) do
    automaton_tag = automaton_tag_fixture()
    %{automaton_tag: automaton_tag}
  end
end
