defmodule BackWeb.AutomatonTagController do
  use BackWeb, :controller

  alias Back.Automatons.AutomatonTags
  alias Back.Automatons.AutomatonTags.AutomatonTag

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    automaton_tag = AutomatonTags.list_automaton_tag()
    render(conn, :index, automaton_tag: automaton_tag)
  end

  def create(conn, %{"automaton_tag" => automaton_tag_params}) do
    with {:ok, %AutomatonTag{} = automaton_tag} <-
           AutomatonTags.create_automaton_tag(automaton_tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton_tag/#{automaton_tag}")
      |> render(:show, automaton_tag: automaton_tag)
    end
  end

  def show(conn, %{"id" => id}) do
    automaton_tag = AutomatonTags.get_automaton_tag!(id)
    render(conn, :show, automaton_tag: automaton_tag)
  end

  def update(conn, %{"id" => id, "automaton_tag" => automaton_tag_params}) do
    automaton_tag = AutomatonTags.get_automaton_tag!(id)

    with {:ok, %AutomatonTag{} = automaton_tag} <-
           AutomatonTags.update_automaton_tag(automaton_tag, automaton_tag_params) do
      render(conn, :show, automaton_tag: automaton_tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    automaton_tag = AutomatonTags.get_automaton_tag!(id)

    with {:ok, %AutomatonTag{}} <- AutomatonTags.delete_automaton_tag(automaton_tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
