defmodule BackWeb.BlockedController do
  use BackWeb, :controller

  alias Back.UserAction
  alias Back.UserAction.Blocked

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    blocked = UserAction.list_blocked()
    render(conn, :index, blocked: blocked)
  end

  def create(conn, %{"blocked" => blocked_params}) do
    with {:ok, %Blocked{} = blocked} <- UserAction.create_blocked(blocked_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/blocked/#{blocked}")
      |> render(:show, blocked: blocked)
    end
  end

  def show(conn, %{"id" => id}) do
    blocked = UserAction.get_blocked!(id)
    render(conn, :show, blocked: blocked)
  end

  def update(conn, %{"id" => id, "blocked" => blocked_params}) do
    blocked = UserAction.get_blocked!(id)

    with {:ok, %Blocked{} = blocked} <- UserAction.update_blocked(blocked, blocked_params) do
      render(conn, :show, blocked: blocked)
    end
  end

  def delete(conn, %{"id" => id}) do
    blocked = UserAction.get_blocked!(id)

    with {:ok, %Blocked{}} <- UserAction.delete_blocked(blocked) do
      send_resp(conn, :no_content, "")
    end
  end
end
