defmodule BackWeb.UserController do
  use BackWeb, :controller

  alias Back.Users
  alias Back.Users.User

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    user = Users.list_user()
    render(conn, :index, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user/#{user.user_id}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => user_id}) do
    user = Users.get_user!(user_id)
    render(conn, :show, user: user)
  end

  def index_pic(conn, _params) do
    user = Users.list_user_with_pic()
    IO.inspect(user)
    render(conn, :index_picture, user: user)
  end

  def show_pic(conn, %{"user_id" => user_id}) do
    user = Users.get_user_pic!(user_id)
    render(conn, :show_picture, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
