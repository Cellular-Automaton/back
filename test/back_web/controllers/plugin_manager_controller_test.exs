defmodule BackWeb.PluginManagerControllerTest do
  use BackWeb.ConnCase

  import Back.Plugins.ManagerFixtures

  alias Back.Plugins.Manager.PluginManager

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all plugin_manager", %{conn: conn} do
      conn = get(conn, ~p"/api/plugin_manager")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plugin_manager" do
    test "renders plugin_manager when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/plugin_manager", plugin_manager: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/plugin_manager/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/plugin_manager", plugin_manager: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plugin_manager" do
    setup [:create_plugin_manager]

    test "renders plugin_manager when data is valid", %{
      conn: conn,
      plugin_manager: %PluginManager{id: id} = plugin_manager
    } do
      conn = put(conn, ~p"/api/plugin_manager/#{plugin_manager}", plugin_manager: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/plugin_manager/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, plugin_manager: plugin_manager} do
      conn = put(conn, ~p"/api/plugin_manager/#{plugin_manager}", plugin_manager: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plugin_manager" do
    setup [:create_plugin_manager]

    test "deletes chosen plugin_manager", %{conn: conn, plugin_manager: plugin_manager} do
      conn = delete(conn, ~p"/api/plugin_manager/#{plugin_manager}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/plugin_manager/#{plugin_manager}")
      end
    end
  end

  defp create_plugin_manager(_) do
    plugin_manager = plugin_manager_fixture()
    %{plugin_manager: plugin_manager}
  end
end
