defmodule BackWeb.PostActionsController do
  use BackWeb, :controller

  alias Back.Posts.PostActions
  alias Back.Posts.PostActions.PostAction

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    posts_actions = PostActions.list_posts_actions()
    render(conn, :index, posts_actions: posts_actions)
  end

  def create(conn, %{"post_actions" => post_actions_params}) do
    with {:ok, %PostAction{} = post_actions} <-
           PostActions.create_post_actions(post_actions_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts_actions/#{post_actions}")
      |> render(:show, post_actions: post_actions)
    end
  end

  def show(conn, %{"id" => id}) do
    post_actions = PostActions.get_post_actions!(id)
    render(conn, :show, post_actions: post_actions)
  end

  def update(conn, %{"id" => id, "post_actions" => post_actions_params}) do
    post_actions = PostActions.get_post_actions!(id)

    with {:ok, %PostAction{} = post_actions} <-
           PostActions.update_post_actions(post_actions, post_actions_params) do
      render(conn, :show, post_actions: post_actions)
    end
  end

  def delete(conn, %{"id" => id}) do
    post_actions = PostActions.get_post_actions!(id)

    with {:ok, %PostAction{}} <- PostActions.delete_post_actions(post_actions) do
      send_resp(conn, :no_content, "")
    end
  end
end
