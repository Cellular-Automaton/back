defmodule BackWeb.VisualController do
  use BackWeb, :controller

  alias Back.Visuals
  alias Back.Visuals.Visual

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    visuals = Visuals.list_visuals()
    render(conn, :index, visuals: visuals)
  end

  def create(conn, %{"visual" => visual_params}) do
    with {:ok, %Visual{} = visual} <- Visuals.create_visual(visual_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/visuals/#{visual}")
      |> render(:show, visual: visual)
    end
  end

  def show(conn, %{"id" => id}) do
    visual = Visuals.get_visual!(id)
    render(conn, :show, visual: visual)
  end

  def update(conn, %{"id" => id, "visual" => visual_params}) do
    visual = Visuals.get_visual!(id)

    with {:ok, %Visual{} = visual} <- Visuals.update_visual(visual, visual_params) do
      render(conn, :show, visual: visual)
    end
  end

  def delete(conn, %{"id" => id}) do
    visual = Visuals.get_visual!(id)

    with {:ok, %Visual{}} <- Visuals.delete_visual(visual) do
      send_resp(conn, :no_content, "")
    end
  end
end
