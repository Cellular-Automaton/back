defmodule BackWeb.TagController do
  use BackWeb, :controller

  alias Back.Automatons.Tags
  alias Back.Automatons.Tags.Tag

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    tag = Tags.list_tag()
    render(conn, :index, tag: tag)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Tags.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tag/#{tag}")
      |> render(:show, tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    render(conn, :show, tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag, tag_params) do
      render(conn, :show, tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
