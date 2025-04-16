defmodule BackWeb.AutomatonController do
  use BackWeb, :controller

  alias Back.Automatons
  alias Back.Automatons.Automaton

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    automaton = Automatons.list_automaton()
    render(conn, :index, automaton: automaton)
  end

  def create(conn, %{"automaton" => automaton_params}) do
    with {:ok, %Automaton{} = automaton} <- Automatons.create_automaton(automaton_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton/#{automaton}")
      |> render(:show, automaton: automaton)
    end
  end

  def show(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)
    render(conn, :show, automaton: automaton)
  end

  def update(conn, %{"id" => id, "automaton" => automaton_params}) do
    automaton = Automatons.get_automaton!(id)

    with {:ok, %Automaton{} = automaton} <-
           Automatons.update_automaton(automaton, automaton_params) do
      render(conn, :show, automaton: automaton)
    end
  end

  def delete(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)

    with {:ok, %Automaton{}} <- Automatons.delete_automaton(automaton) do
      send_resp(conn, :no_content, "")
    end
  end
end
