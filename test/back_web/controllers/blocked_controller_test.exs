defmodule BackWeb.BlockedControllerTest do
  use BackWeb.ConnCase

  import Back.UserActionFixtures

  alias Back.UserAction.Blocked

  @create_attrs %{
    blocked_id: "some blocked_id",
    time_unblock: ~N[2025-04-15 18:04:00],
    blocked_at: ~N[2025-04-15 18:04:00]
  }
  @update_attrs %{
    blocked_id: "some updated blocked_id",
    time_unblock: ~N[2025-04-16 18:04:00],
    blocked_at: ~N[2025-04-16 18:04:00]
  }
  @invalid_attrs %{blocked_id: nil, time_unblock: nil, blocked_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    @tag :skip
    test "lists all blocked", %{conn: conn} do
      conn = get(conn, ~p"/api/blocked")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create blocked" do
    @tag :skip
    test "renders blocked when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/blocked", blocked: @create_attrs)
      assert %{"blocked_id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/blocked/#{id}")

      assert %{
               "blocked_id" => ^id,
               "blocked_at" => "2025-04-15T18:04:00",
               "time_unblock" => "2025-04-15T18:04:00"
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/blocked", blocked: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update blocked" do
    setup [:create_blocked]

    @tag :skip
    test "renders blocked when data is valid", %{
      conn: conn,
      blocked: %Blocked{blocked_id: id} = blocked
    } do
      conn = put(conn, ~p"/api/blocked/#{blocked}", blocked: @update_attrs)
      assert %{"blocked_id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/blocked/#{id}")

      assert %{
               "blocked_id" => ^id,
               "blocked_at" => "2025-04-16T18:04:00",
               "time_unblock" => "2025-04-16T18:04:00"
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, blocked: blocked} do
      conn = put(conn, ~p"/api/blocked/#{blocked}", blocked: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete blocked" do
    setup [:create_blocked]

    @tag :skip
    test "deletes chosen blocked", %{conn: conn, blocked: blocked} do
      conn = delete(conn, ~p"/api/blocked/#{blocked}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/blocked/#{blocked}")
      end
    end
  end

  defp create_blocked(_) do
    blocked = blocked_fixture()
    %{blocked: blocked}
  end
end
