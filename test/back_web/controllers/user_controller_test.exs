defmodule BackWeb.UserControllerTest do
  use BackWeb.ConnCase

  import Back.UsersFixtures

  alias Back.Users.User

  @create_attrs %{
    username: "some username",
    user_id: "some user_id",
    email: "some email",
    phone: "some phone",
    created_at: "some created_at",
    verified: true
  }
  @update_attrs %{
    username: "some updated username",
    user_id: "some updated user_id",
    email: "some updated email",
    phone: "some updated phone",
    created_at: "some updated created_at",
    verified: false
  }
  @invalid_attrs %{
    username: nil,
    user_id: nil,
    email: nil,
    phone: nil,
    created_at: nil,
    verified: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    @tag :skip
    test "lists all user", %{conn: conn} do
      conn = get(conn, ~p"/api/user")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    @tag :skip
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/user", user: @create_attrs)
      assert %{"user_id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/user/#{id}")

      assert %{
               "user_id" => ^id,
               "created_at" => "some created_at",
               "email" => "some email",
               "phone" => "some phone",
               "username" => "some username",
               "verified" => true
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/user", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    @tag :skip
    test "renders user when data is valid", %{conn: conn, user: %User{user_id: id} = user} do
      conn = put(conn, ~p"/api/user/#{user}", user: @update_attrs)
      assert %{"user_id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/user/#{id}")

      assert %{
               "user_id" => ^id,
               "created_at" => "some updated created_at",
               "email" => "some updated email",
               "phone" => "some updated phone",
               "username" => "some updated username",
               "verified" => false
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/user/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    @tag :skip
    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/user/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/user/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
