defmodule BackWeb.CommentController do
  use BackWeb, :controller

  alias Back.Comments
  alias Back.Comments.Comment

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    comment = Comments.list_comment()
    render(conn, :index, comment: comment)
  end

  def create(conn, %{"comment" => comment_params}) do
    IO.inspect(comment_params)

    with {:ok, %Comment{} = comment} <- Comments.create_comment(comment_params) do
      IO.inspect(comment)

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/comment/#{comment.comment_id}")
      |> render(:show, comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, :show, comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
      render(conn, :show, comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
