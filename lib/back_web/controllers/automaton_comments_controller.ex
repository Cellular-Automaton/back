defmodule BackWeb.AutomatonCommentsController do
  use BackWeb, :controller

  alias Back.AutomatonsComments
  alias Back.AutomatonsComments.AutomatonComments

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    automaton_comment = AutomatonsComments.list_automaton_comment()
    render(conn, :index, automaton_comment: automaton_comment)
  end

  def create(conn, %{"automaton_comments" => automaton_comments_params}) do
    with {:ok, %AutomatonComments{} = automaton_comments} <- AutomatonsComments.create_automaton_comments(automaton_comments_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton_comment/#{automaton_comments}")
      |> render(:show, automaton_comments: automaton_comments)
    end
  end

  def show(conn, %{"id" => id}) do
    automaton_comments = AutomatonsComments.get_automaton_comments!(id)
    render(conn, :show, automaton_comments: automaton_comments)
  end

  def update(conn, %{"id" => id, "automaton_comments" => automaton_comments_params}) do
    automaton_comments = AutomatonsComments.get_automaton_comments!(id)

    with {:ok, %AutomatonComments{} = automaton_comments} <- AutomatonsComments.update_automaton_comments(automaton_comments, automaton_comments_params) do
      render(conn, :show, automaton_comments: automaton_comments)
    end
  end

  def delete(conn, %{"id" => id}) do
    automaton_comments = AutomatonsComments.get_automaton_comments!(id)

    with {:ok, %AutomatonComments{}} <- AutomatonsComments.delete_automaton_comments(automaton_comments) do
      send_resp(conn, :no_content, "")
    end
  end
end
