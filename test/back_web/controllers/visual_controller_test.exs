defmodule BackWeb.VisualControllerTest do
  use BackWeb.ConnCase

  import Back.VisualsFixtures

  alias Back.Visuals.Visual

  @create_attrs %{
    name: "some name",
    description: "some description",
    assets_link: "some assets_link"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    assets_link: "some updated assets_link"
  }
  @invalid_attrs %{name: nil, description: nil, assets_link: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all visuals", %{conn: conn} do
      conn = get(conn, ~p"/api/visuals")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create visual" do
    test "renders visual when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/visuals", visual: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/visuals/#{id}")

      assert %{
               "id" => ^id,
               "assets_link" => "some assets_link",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/visuals", visual: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update visual" do
    setup [:create_visual]

    test "renders visual when data is valid", %{conn: conn, visual: %Visual{id: id} = visual} do
      conn = put(conn, ~p"/api/visuals/#{visual}", visual: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/visuals/#{id}")

      assert %{
               "id" => ^id,
               "assets_link" => "some updated assets_link",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, visual: visual} do
      conn = put(conn, ~p"/api/visuals/#{visual}", visual: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete visual" do
    setup [:create_visual]

    test "deletes chosen visual", %{conn: conn, visual: visual} do
      conn = delete(conn, ~p"/api/visuals/#{visual}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/visuals/#{visual}")
      end
    end
  end

  defp create_visual(_) do
    visual = visual_fixture()
    %{visual: visual}
  end
end
